#ifndef FLOW_HPP_
#define FLOW_HPP_

#include <algorithm>
#include <cstring>
#include <string>
#include <map>
#include <unordered_map>
#include <vector>
#include <iostream>

#include "../Utils/utils.hpp"

const uint64_t Scale = 1 << 14;
const uint64_t PropDelay = (1500 * 8 / 1000) * 1000;  // 1500B, 1000Mbps unit:ns
const UScaledNs Period = 2048 * Scale;  // one period 32ms

struct FLOW {
    int flow_id;
    std::vector<SCHEDULE> path;
    std::unordered_map<ID, size_t> ID2index;

    bool has_link(ID x, ID y) const {
        // check if link (x, y) is in path
        return ID2index.find(x) != ID2index.end() &&
               path[ID2index.at(x)].to_id == y;
    }

    UScaledNs get_scheduled_rx_ts(ID switch_id) const {
        for (const SCHEDULE& link : path)
            // if (link.to_id == switch_id) return (link.start % 2048) * Scale + PropDelay;
            if (link.to_id == switch_id) return (link.start + PropDelay) % (path.empty() ? Period : path.back().period);
        return 0;
    }

    UScaledNs get_scheduled_tx_ts(ID switch_id) const {
        for (const SCHEDULE& link : path)
            // if (link.from_id == switch_id) return (link.start % 2048) * Scale;
            if (link.from_id == switch_id) return link.start % (path.empty() ? Period : path.back().period);
        return 0;
    }

    size_t get_index(ID id) const {
        // index should between 0~path.size()
        // other values are invalid,
        // indicating this id is not on this flow
        if (ID2index.find(id) != ID2index.end()) return ID2index.at(id);
        return path.size() + 1;
        // for (size_t i = 0; i < path.size(); i++)
        //     if (path[i].from_id == id) return 0;
        // return path.size() + (path.back().to_id == id ? 0 : 1);
    }

    ID get_src_id() const { return path.front().from_id; }
    ID get_dst_id() const { return path.back().to_id; }

    void initialize() {
        this->ID2index.clear();
        size_t len = path.size();
        for (size_t i = 0; i < len; i++) {
            this->ID2index[path[i].from_id] = i;
        }
        this->ID2index[path.back().to_id] = len;
    }

    void count_links(std::unordered_map<LINK, int>& linkCnt) const {
        for (const SCHEDULE& link : path) {
            // std::cout << (unsigned)linkConvertor(link.from_id, link.to_id) << std::endl;
            linkCnt[linkConvertor(link.from_id, link.to_id)]++;
        }
    }
};

struct PKTLOG {
    int pkt_id;
    uint64_t tx;
    uint64_t rx;
    uint64_t lat;
    std::unordered_map<ID, TIMESTAMP> ts_logs;
};

struct FLOWLOG {
    int flow_id;
    std::unordered_map<uint32_t, PKTLOG> packet_logs;
};

/* check whether flow_logs has a record with #flow_id */
bool has_flowlog(const std::unordered_map<int, FLOWLOG>& flow_logs, int flow_id);
/* check whether flow_logs has a record with #flow_id #pkt_id */
bool has_pktlog(const std::unordered_map<int, FLOWLOG>& flow_logs, int flow_id, int pkt_id);
/* check whether flow_logs has a record with #flow_id #pkt_id #host_id */
bool has_ts(const std::unordered_map<int, FLOWLOG>& flow_logs, int flow_id, int pkt_id, ID host_id);

/* return flow with #flow_id */
FLOWLOG& get_flowlog(std::unordered_map<int, FLOWLOG>& flow_logs, int flow_id,
                           bool check_existence = false);
/* return packet with #flow_id #pkt_id */
PKTLOG& get_pktlog(std::unordered_map<int, FLOWLOG>& flow_logs, int flow_id,
                   int pkt_id, bool check_existence = false);
/* return timestamp with #flow_id #pkt_id #host_id */
TIMESTAMP& get_ts(std::unordered_map<int, FLOWLOG>& flow_logs, int flow_id,
                  int pkt_id, ID host_id, bool check_existence = false);

/* output first  */
void output_postcards(std::map<int, FLOW>& flows,
                      std::unordered_map<int, FLOWLOG>& flow_logs,
                      int K = 5);

void output_line_delay(std::map<int, FLOW>& flows,
                      std::unordered_map<int, FLOWLOG>& flow_logs,
                      int K = 5);

#endif