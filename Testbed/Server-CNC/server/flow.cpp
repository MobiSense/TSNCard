#include "flow.hpp"

bool has_flowlog(const std::unordered_map<int, FLOWLOG>& flow_logs, int flow_id) {
    return flow_logs.find(flow_id) != flow_logs.end();
}

bool has_pktlog(const std::unordered_map<int, FLOWLOG>& flow_logs, int flow_id,
                int pkt_id) {
    return has_flowlog(flow_logs, flow_id) &&
           flow_logs.at(flow_id).packet_logs.find(pkt_id) !=
               flow_logs.at(flow_id).packet_logs.end();
}

bool has_ts(const std::unordered_map<int, FLOWLOG>& flow_logs, int flow_id,
            int pkt_id, ID host_id) {
    return has_flowlog(flow_logs, flow_id) &&
           has_pktlog(flow_logs, flow_id, pkt_id) &&
           flow_logs.at(flow_id).packet_logs.at(pkt_id).ts_logs.find(host_id) !=
               flow_logs.at(flow_id).packet_logs.at(pkt_id).ts_logs.end();
}

FLOWLOG& get_flowlog(std::unordered_map<int, FLOWLOG>& flow_logs, int flow_id, bool check_existence) {
    if (check_existence && flow_logs.find(flow_id) == flow_logs.end()) {
        std::cout << "unknown flow id: " << flow_id << std::endl;
        exit(1);
    }
    return flow_logs.at(flow_id);
}

PKTLOG& get_pktlog(std::unordered_map<int, FLOWLOG>& flow_logs, int flow_id,
                   int pkt_id, bool check_existence) {
    FLOWLOG& flow_log = get_flowlog(flow_logs, flow_id, check_existence);

    if (check_existence &&
        flow_log.packet_logs.find(pkt_id) == flow_log.packet_logs.end()) {
        std::cout << "unknown pkt id: " << pkt_id << " in flow#" << flow_id
                  << std::endl;
        exit(1);
    }
    return flow_log.packet_logs.at(pkt_id);
}

TIMESTAMP& get_ts(std::unordered_map<int, FLOWLOG>& flow_logs, int flow_id,
                  int pkt_id, ID host_id, bool check_existence) {
    PKTLOG& pkt_log = get_pktlog(flow_logs, flow_id, pkt_id, check_existence);

    if (check_existence && pkt_log.ts_logs.find(host_id) == pkt_log.ts_logs.end()) {
        std::cout << "unknown host id: " << (unsigned)host_id << " in flow#"
                  << flow_id << " packet#" << pkt_id << std::endl;
        exit(1);
    }
    return pkt_log.ts_logs[host_id];
}

void output_postcards(std::map<int, FLOW>& flows,
                      std::unordered_map<int, FLOWLOG>& flow_logs,
                      int K) {
    for (const auto& it : flows) {
        int flow_id = it.first;
        // int flow_id = 2;
        for (int pkt_id = 0; pkt_id < K; pkt_id++) {
            const std::vector<SCHEDULE>& path = flows[flow_id].path;
            if (!has_pktlog(flow_logs, flow_id, pkt_id)) continue;
            UScaledNs period = path.back().period;
            // std::cout << "period = " << period << ", Scale = " << Scale << std::endl;
            PKTLOG& pkt_log = get_pktlog(flow_logs, flow_id, pkt_id, true);
            // if (pkt_log.rx / period < 890 || pkt_log.tx / period > 900) continue;
            std::cout << "flow id: " << flow_id << "; packet id: " << pkt_id
                      << "; Expected: " << (path.front().start % period) * 1. / Scale << "~"
                      << (path.front().end % period) * 1. / Scale << "; tx timestamp: ("
                      << pkt_log.tx / period << ", "
                      << (pkt_log.tx % period) * 1. / Scale << ")"
                      << "; rx timestamp: (" << pkt_log.rx / period << ", "
                      << (pkt_log.rx % period) * 1. / Scale << ")" << std::endl;
            
            for (const auto& link : path) {
                ID switch_id = link.from_id;
                if (link.from_id == path.front().from_id) continue;
                if (has_ts(flow_logs, flow_id, pkt_id, switch_id)) {
                    TIMESTAMP& ts = get_ts(flow_logs, flow_id, pkt_id, switch_id, false);
                    std::cout << "    switch id: " << (unsigned)ts.switch_id
                              << "; Expected: " << (link.start % period) * 1. / Scale << "~"
                              << (link.end % period) * 1. / Scale
                              << "; ingress timestamp: (" << ts.rx / period << ", "
                              << (ts.rx % period) * 1. / Scale << ")"
                              << "; egress timestamp: (" << ts.tx / period << ", "
                              << (ts.tx % period) * 1. / Scale << ")" << std::endl;
                } else {
                    std::cout << "    [ERROR] loss timestamp at " << (unsigned)switch_id 
                              << "; Expected: " << (link.start % period) * 1. / Scale << "~" << (link.end % period) * 1. / Scale
                              << std::endl;
                    // break;
                }
            }
        }
        std::cout << std::endl;
    }
}

void output_line_delay(std::map<int, FLOW>& flows,
                      std::unordered_map<int, FLOWLOG>& flow_logs,
                      int K) {
    for (const auto& it : flows) {
        int flow_id = it.first;
        const auto& flow = it.second;
        const auto& path = flow.path;
        for (int pkt_id = 0; pkt_id < K; pkt_id++) {
            if (!has_pktlog(flow_logs, flow_id, pkt_id)) continue;
            PKTLOG& pkt_log = get_pktlog(flow_logs, flow_id, pkt_id, true);

            for (const auto& link : path) {
                ID from_id = link.from_id;
                ID to_id  = link.to_id;
                
                bool v = true;
                UScaledNs tx, rx;
                if (from_id == flow.get_src_id()) {
                    tx = pkt_log.tx;
                } else
                {
                    if (has_ts(flow_logs, flow_id, pkt_id, from_id)) {
                        TIMESTAMP& ts = get_ts(flow_logs, flow_id, pkt_id, from_id, false);
                        tx = ts.tx;
                    } else
                        v = false;
                }

                if (to_id == flow.get_dst_id()) {
                    rx = pkt_log.rx;
                } else
                {
                    if (has_ts(flow_logs, flow_id, pkt_id, to_id)) {
                        TIMESTAMP& ts = get_ts(flow_logs, flow_id, pkt_id, to_id, false);
                        rx = ts.rx;
                    } else
                        v = false;
                }

                if (v) std::cout << rx - tx << std::endl;
            }
        }
    }
}
