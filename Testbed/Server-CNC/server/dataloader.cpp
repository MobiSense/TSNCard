#include <dirent.h>
#include <unistd.h>

#include <string>
#include <vector>
#include <cstring>
#include <cstdlib>
#include <fstream>
#include <iostream>
#include <algorithm>

#include "dataloader.h"
#include "../Utils/json.hpp"


void sort_from_src_to_dst(std::vector<SCHEDULE>& path) {
    int origin_length = path.size();
    std::vector<SCHEDULE> path_copy(path);
    path.clear();

    std::map<ID, int> ingress, egress;
    ingress.clear();
    egress.clear();
    for (const auto& node : path_copy) {
        egress[node.from_id]++;
        ingress[node.to_id]++;
    }
    for (const auto& it : ingress) assert(it.second == 1);
    for (const auto& it : egress) assert(it.second == 1);

    ID start_id, end_id;
    bool has_start, has_end;
    has_start = has_end = false;
    for (const auto& it : egress) {
        if (ingress.find(it.first) == ingress.end()) {
            assert(has_start == false);
            has_start = true;
            start_id = it.first;
        }
    }
    for (const auto& it : ingress) {
        if (egress.find(it.first) == egress.end()) {
            assert(has_end == false);
            has_end = true;
            end_id = it.first;
        }
    }
    assert(has_start == true);
    assert(has_end == true);

    ID cur_id = start_id;
    while (cur_id != end_id) {
        for (auto& node : path_copy)
            if (node.from_id == cur_id) {
                path.emplace_back(node);
                cur_id = node.to_id;
                break;
            }
    }

    assert(int(path.size()) == origin_length);
}

void load_latest_log_data(std::unordered_map<int, FLOWLOG>& flow_logs,
                          std::string& latest_log_name) {
    flow_logs.clear();

    std::string log_dir = "logs/";

    DIR* device_log_dir = opendir((log_dir + "device").c_str());
    DIR* switch_log_dir = opendir((log_dir + "switch").c_str());

    if (device_log_dir == NULL) {
        std::cerr << "Cannot open directory: " << log_dir + "device"
                  << std::endl;
        return;
    }
    if (switch_log_dir == NULL) {
        std::cerr << "Cannot open directory: " << log_dir + "switch"
                  << std::endl;
        return;
    }

    struct dirent* entry;
    if (latest_log_name == "") {
        while ((entry = readdir(device_log_dir)) != NULL) {
            std::string name = entry->d_name;
            if (name == "." || name == "..") {
                continue;  // Skip . and ..
            }

            if (entry->d_type == DT_DIR) {
                // std::cout << "Directory: " << name << std::endl;
                if (latest_log_name == "" or latest_log_name < name)
                    latest_log_name = name;
            } else {
                // std::cout << "File: " << name << std::endl;
            }
        }
    }

    // latest_log_name = "2023.07.30-16:52:16";
    std::cout << "log to analyze: " << latest_log_name << std::endl;

    std::string full_latest_log_name = log_dir + "device/" + latest_log_name;
    DIR* latest_device_log_dir = opendir(full_latest_log_name.c_str());
    while ((entry = readdir(latest_device_log_dir)) != NULL) {
        std::string name = entry->d_name;
        if (name == "." || name == "..") {
            continue;  // Skip . and ..
        }

        std::string fullpath = full_latest_log_name + "/" + name;
        if (entry->d_type == DT_DIR) {
            // std::cout << "Directory: " << name << std::endl;
        } else {
            // std::cout << "File: " << name << std::endl;
            if (name.substr(0, 12) == "critical_log") {
                // ID device_id =
                //     std::stoi(name.substr(13, name.length() - 4 - 13));

            } else if (name.substr(0, 10) == "packet_log") {
                // ID device_id =
                //     std::stoi(name.substr(11, name.length() - 4 - 11));

                std::ifstream packet_log(fullpath);
                if (!packet_log.is_open()) {
                    exit(1);
                }

                std::string line;
                // first line is title
                // Seq ID, Pkt ID, TX timestamp, RX timestamp, Latency
                std::getline(packet_log, line);
                while (std::getline(packet_log, line)) {
                    // cout << line << endl;

                    // remove space
                    line.erase(std::remove(line.begin(), line.end(), ' '),
                               line.end());
                    if (std::count(line.begin(), line.end(), ',') != 4 ||
                        line.back() == ',') {
                        // cout << line << endl;
                        continue;
                    }

                    std::stringstream lineStream(line);
                    std::string temp[5];
                    bool full_line = true;
                    for (int i = 0; i < 5; i++)
                        if (!std::getline(lineStream, temp[i], ','))
                            full_line = false;

                    // if (std::count(line.begin(), line.end(), ',') != 4) {
                    //     for (int i = 0; i < 5; i++) cout << temp[i] << " ";
                    //     cout << endl;
                    // }

                    if (full_line) {
                        // flow_id
                        // cout << "temp[0]: " << temp[0] << endl;
                        int flow_id = stoi(temp[0], 0, 16);
                        // pkt_id
                        // cout << "temp[1]: " << temp[1] << endl;
                        int pkt_id = stoi(temp[1], 0, 10);
                        // tx
                        // cout << "temp[2]: " << temp[2] << endl;
                        uint64_t tx = stoull(temp[2]);
                        // rx
                        // cout << "temp[3]: " << temp[3] << endl;
                        uint64_t rx = stoull(temp[3]);
                        // latency
                        // cout << "temp[4]: " << temp[4] << endl;
                        uint64_t lat = stoull(temp[4]);

                        if (flow_logs.find(flow_id) == flow_logs.end()) {
                            // cout << "new flow: #" << flow_id << endl;
                            flow_logs[flow_id].flow_id = flow_id;
                            flow_logs[flow_id].packet_logs.clear();
                        }
                        // cout << flow_id << " " << pkt_id << endl;
                        if (flow_logs[flow_id].packet_logs.find(pkt_id) !=
                               flow_logs[flow_id].packet_logs.end())
                            std::cout << flow_id << " " << pkt_id << std::endl;
                        // assert(flow_logs[flow_id].packet_logs.find(pkt_id) ==
                        //        flow_logs[flow_id].packet_logs.end());
                        flow_logs[flow_id].packet_logs[pkt_id].pkt_id = pkt_id;
                        flow_logs[flow_id].packet_logs[pkt_id].tx = tx;
                        flow_logs[flow_id].packet_logs[pkt_id].rx = rx;
                        flow_logs[flow_id].packet_logs[pkt_id].lat = lat;
                        flow_logs[flow_id].packet_logs[pkt_id].ts_logs.clear();
                    }

                    // skip raw data
                    for (int i = 0; i < 4; i++) std::getline(packet_log, line);
                }

                packet_log.close();
            }
        }
    }
    closedir(latest_device_log_dir);

    full_latest_log_name = log_dir + "switch/" + latest_log_name;
    DIR* latest_switch_log_dir =
        opendir((log_dir + "switch/" + latest_log_name).c_str());
    while ((entry = readdir(latest_switch_log_dir)) != NULL) {
        std::string name = entry->d_name;
        if (name == "." || name == "..") {
            continue;  // Skip . and ..
        }

        std::string fullpath = full_latest_log_name + "/" + name;
        if (entry->d_type == DT_DIR) {
            // std::cout << "Directory: " << name << std::endl;
        } else {
            // cout << name.substr(14, name.length() - 4 - 14) << endl;
            // ID switch_id = std::stoi(name.substr(14, name.length() - 4 -
            // 14));

            std::ifstream timestamp_log(fullpath);
            if (!timestamp_log.is_open()) {
                exit(1);
            }

            std::string line;
            while (std::getline(timestamp_log, line)) {
                if (line.find('\0', 0) != std::string::npos) break;

                int flow_id = 0, pkt_id = 0;
                if (std::getline(timestamp_log, line)) {
                    if (line.find('\0', 0) != std::string::npos) break;
                    std::string flow_id_str = line.substr(45, 4);
                    std::string pkt_id_str = line.substr(49, 4) + line.substr(54, 4);
                    flow_id = (int)convert_hex(flow_id_str.c_str(), 4);
                    pkt_id = (int)convert_hex(pkt_id_str.c_str(), 8);
                } else
                {
                    break;
                }

                if (std::getline(timestamp_log, line)) {
                    if (line.find('\0', 0) != std::string::npos) break;
                } else
                {
                    break;
                }

                if (std::getline(timestamp_log, line)) {
                    if (line.find('\0', 0) != std::string::npos) break;
                } else
                {
                    break;
                }

                if (std::getline(timestamp_log, line)) {
                    if (line.length() < 90) break;
                    if (line.find('\0', 0) != std::string::npos) break;
                } else
                {
                    break;
                }

                // convert string to uint8_t*?
                // then coput uint8_t* to TIMESTAMP?

                if (!has_pktlog(flow_logs, flow_id, pkt_id)) {
                    // TODO: maybe packet loss will goto this line
                    if (!has_flowlog(flow_logs, flow_id)) {
                        flow_logs[flow_id].flow_id = flow_id;
                        flow_logs[flow_id].packet_logs.clear();
                    }
                    flow_logs[flow_id].packet_logs[pkt_id];
                    // continue;
                }
                ID switch_id = (uint8_t)convert_hex(line.c_str() + 88, 2);
                PKTLOG& pkt_log = get_pktlog(flow_logs, flow_id, pkt_id);
                if (pkt_log.ts_logs.find(switch_id) != pkt_log.ts_logs.end())
                    std::cout << flow_id << " " << pkt_id << " " << (unsigned)switch_id << std::endl;
                assert(pkt_log.ts_logs.find(switch_id) == pkt_log.ts_logs.end());
                TIMESTAMP& ts = pkt_log.ts_logs[switch_id];
                // convert char* to int
                ts.rx = convert_hex(line.c_str(), 16);
                ts.tx = convert_hex(line.c_str() + 16, 16);
                for (int i = 0; i < 6; i++)
                    ts.dst_mac[i] =
                        (uint8_t)convert_hex(line.c_str() + (32 + i * 2), 2);
                for (int i = 0; i < 6; i++)
                    ts.src_mac[i] =
                        (uint8_t)convert_hex(line.c_str() + (44 + i * 2), 2);
                ts.md5.md5[0] = convert_hex(line.c_str() + 56, 16);
                ts.md5.md5[1] = convert_hex(line.c_str() + 72, 16);
                ts.switch_id = (uint8_t)convert_hex(line.c_str() + 88, 2);

                // cout << "Rx Timestamp: " << std::setfill('0') <<
                // std::setw(16)
                //      << std::hex << ts.rx << endl;
                // cout << "Tx Timestamp: " << std::setfill('0') <<
                // std::setw(16)
                //      << std::hex << ts.tx << endl;
                // cout << "Dst MAC:      ";
                // for (int i = 0; i < 6; i++) {
                //     cout << std::setfill('0') << std::setw(2) << std::hex
                //          << (unsigned)ts.dst_mac[i];
                // }
                // cout << endl;
                // cout << "Src MAC:      ";
                // for (int i = 0; i < 6; i++) {
                //     cout << std::setfill('0') << std::setw(2) << std::hex
                //          << (unsigned)ts.src_mac[i];
                // }
                // cout << endl;
            }
            timestamp_log.close();
        }
    }
    closedir(latest_switch_log_dir);
}

void read_global_configuration(std::map<int, FLOW>& flows,
                          std::unordered_map<LINK, int>& linkCnt,
                          const std::string& latest_log_name) {
    std::unordered_map<int, int> node_cnt;
    node_cnt.clear();

    std::string filename = "logs/configs/" + latest_log_name + "/schedule.json";
    std::ifstream fin(filename);
    // cout << filename << endl;
    nlohmann::json config = nlohmann::json::parse(fin);
    // cout << "succefully reading json" << endl;
    flows.clear();
    for (const auto& single_configuration : config) {
        if (single_configuration["type"] != "link") continue;
        for (const auto& schedule : single_configuration["schedule"]) {
            SCHEDULE node_sche;
            int flow_id = schedule["flow_id"];
            node_sche.flow_id = flow_id;
            node_sche.period = schedule["period"].get<UScaledNs>() * Scale;
            node_sche.start = schedule["start"].get<UScaledNs>() * Scale;
            node_sche.end = schedule["end"].get<UScaledNs>() * Scale;
            node_sche.from_id = single_configuration["from"];
            node_sche.to_id = single_configuration["to"];
            node_sche.port = single_configuration["from_port"];
            if (flows.find(flow_id) == flows.end()) {
                flows[flow_id].flow_id = flow_id;
                flows[flow_id].path.clear();
            }
            flows[flow_id].path.emplace_back(node_sche);

            node_cnt[node_sche.to_id] += 1;
        }
    }

    linkCnt.clear();
    for (auto& it : flows) {
        FLOW& flow = it.second;
        sort_from_src_to_dst(flow.path);
        // for (const auto& node : flow.path)
        //     cout << unsigned(node.from_id) << "->";
        // cout << unsigned(flow.path.back().to_id) << endl;
        flow.initialize();
        flow.count_links(linkCnt);
    }


    // for (const auto& it: node_cnt) {
    //     cout << "#" << it.first << ": " << it.second << endl;
    // }

    fin.close();
}

void read_ip_configuration(const std::string& filename,
                           std::unordered_map<ID, std::string>& ID2PSIP) {
    std::ifstream fin(filename);
    nlohmann::json config = nlohmann::json::parse(fin);
    ID2PSIP.clear();
    for (const auto& it : config) ID2PSIP[it["id"]] = it["ip"];
    fin.close();
}

void read_simulation_data(const std::string& filename,
                          std::vector<ID>& node_list,
                          std::map<int, FLOW>& flows,
                          std::unordered_map<LINK, int>& linkCnt,
                          std::unordered_map<int, FLOWLOG>& flow_logs,
                          std::vector<ID>& root_cause_nodes,
                          int& error_flow, int& error_pkt) {
    // std::string filename = "logs/new_simulation_log/Ring6/new_log_1699966626003.json";
    // std::string filename = "logs/new_simulation_log/new_log_6.json";
    std::ifstream fin(filename);
    // cout << filename << endl;
    nlohmann::json simulation_data = nlohmann::json::parse(fin);
    const nlohmann::json& topology = simulation_data["topology"];
    const nlohmann::json& flow_schedule = simulation_data["flow_schedule"];
    const nlohmann::json& postcards = simulation_data["postcards"];
    const nlohmann::json& errors = simulation_data["errors"];
    const nlohmann::json& diffusion = simulation_data["diffusion"];

    for (const auto& it: topology) {
        node_list.emplace_back(it["src_node_id"].get<ID>());
        node_list.emplace_back(it["dst_node_id"].get<ID>());
    }
    std::sort(node_list.begin(), node_list.end());
    auto last = std::unique(node_list.begin(), node_list.end());
    node_list.erase(last, node_list.end());

    // for (ID x: node_list) std::cout << int(x) << " ";
    // std::cout << std::endl;
    // std::cout << topology << std::endl;

    flow_logs.clear();
    flows.clear();

    for (const auto& single_flow_schedule: flow_schedule) {
        // init postcards
        int flow_id = single_flow_schedule["flow_id"].get<int>();
        flow_logs[flow_id].flow_id = flow_id;
        flow_logs[flow_id].packet_logs.clear();

        // get pre-schedule
        flows[flow_id].flow_id = flow_id;
        flows[flow_id].path.clear();

        for (const auto& single_hop_schedule: single_flow_schedule["hop_schedule"]) {
            SCHEDULE node_sche;
            node_sche.flow_id = flow_id;
            node_sche.period = static_cast<UScaledNs>(single_flow_schedule["period"].get<UScaledNs>() * 1000);

            node_sche.start = static_cast<UScaledNs>(single_hop_schedule["tx_timestamp"].get<double>() * 1000);
            node_sche.end = node_sche.start + 1 * Scale; // TODO: check if +1 is enough

            node_sche.from_id = single_hop_schedule["node_id"].get<ID>();
            // node_sche.to_id = 
            node_sche.port = single_hop_schedule["port"].get<uint16_t>();
            
            if (!flows[flow_id].path.empty()) {
                flows[flow_id].path.back().to_id = node_sche.from_id;
            } else
            {
                assert( single_flow_schedule["src_node_id"].get<ID>() == node_sche.from_id );
            }
            flows[flow_id].path.emplace_back(node_sche);
        }
        
        flows[flow_id].path.back().to_id = single_flow_schedule["dst_node_id"].get<ID>();
    }

    linkCnt.clear();
    for (auto& it : flows) {
        FLOW& flow = it.second;
        sort_from_src_to_dst(flow.path);
        flow.initialize();
        flow.count_links(linkCnt);
    }

    // for (const auto& it : flows) {
    //     std::cout << "flow #" << it.first << ": ";
    //     for (const auto& p: it.second.path) {
    //         std::cout << int(p.from_id) << "->";
    //     }
    //     std::cout << int(it.second.path.back().to_id) << std::endl;
    // }

    // postcards
    for (const auto& postcard: postcards) {
        int flow_id = postcard["flow_id"].get<int>();
        uint32_t pkt_id = postcard["pkt_id"].get<uint32_t>();
        ID node_id = postcard["node_id"].get<ID>();

        // std::cout << flow_id << " " << pkt_id << " " << int(node_id) << std::endl;

        if (flow_logs[flow_id].packet_logs.find(pkt_id) == 
            flow_logs[flow_id].packet_logs.end()) {
            flow_logs[flow_id].packet_logs[pkt_id].pkt_id = pkt_id;
            flow_logs[flow_id].packet_logs[pkt_id].ts_logs.clear();
        }

        PKTLOG& pkt_log = flow_logs[flow_id].packet_logs[pkt_id];

        assert(postcard.contains("rx") || postcard.contains("tx"));

        if (!postcard.contains("rx")) {
            // cout << "src postcard: ";
            // cout << postcard << endl;
            pkt_log.tx = static_cast<UScaledNs>(postcard["tx"].get<double>() * 1000);
            // std::cout << "source of flow #" << flow_id << ": " << "node " << static_cast<int>(node_id) << std::endl;
            pkt_log.ts_logs[node_id].switch_id = node_id;
            pkt_log.ts_logs[node_id].tx = pkt_log.tx;
        } else
        if (!postcard.contains("tx")) {
            // cout << "dst postcard: ";
            // cout << postcard << endl;
            pkt_log.rx = static_cast<UScaledNs>(postcard["rx"].get<double>() * 1000);
            // std::cout << "sink of flow #" << flow_id << ": " << "node " << static_cast<int>(node_id) << std::endl;
            pkt_log.ts_logs[node_id].switch_id = node_id;
            pkt_log.ts_logs[node_id].rx = pkt_log.rx;
        }
        else {
            // cout << "sw postcard:";
            // cout << postcard << endl;
            pkt_log.ts_logs[node_id].switch_id = node_id;
            pkt_log.ts_logs[node_id].rx = static_cast<UScaledNs>(postcard["rx"].get<double>() * 1000);
            pkt_log.ts_logs[node_id].tx = static_cast<UScaledNs>(postcard["tx"].get<double>() * 1000);
            // dst_mac & src_mac is unused
            // md5 is unused in offline analy sis
        }
    }

    // diffusion effect
    root_cause_nodes.clear();
    for (const auto& error: errors) {
        root_cause_nodes.push_back(error["node_id"].get<ID>());
    }
    error_flow = diffusion["flow_id"].get<int>();
    error_pkt = diffusion["pkt_id"].get<int>();

    std::cout << "root cause at node ";
    for (const auto& error: errors) {
        if (error["type"] == "Gate") {
            std::cout << "(#" << error["node_id"].get<int>() << ") ";
        } else
        if (error["type"] == "Queue") {
            std::cout << "(#" << error["node_id"].get<int>() << ", " << error["pkt_id_x"].get<int>() << ") ";
        } else
        {
            std::cout << "(#" << error["node_id"].get<int>() << ", " << error["pkt_id"].get<int>() << ") ";
        }
    }
    std::cout << std::endl;
    std::cout << "diffusion effect at flow #" << error_flow << " at pkt #" << error_pkt << std::endl;

    fin.close();
}

void read_bayes_result(BayesProb& bayesProb) {
    // bayesProb.set_P();
    std::string filename = "bayes_output.json";
    std::ifstream fin(filename);
    nlohmann::json bayesProb_json = nlohmann::json::parse(fin);

    for (const auto& single_prob: bayesProb_json["P"]) {
        ID y = single_prob["y"].get<ID>();
        ID x = single_prob["x"].get<ID>();
        int flow_id = single_prob["flow_id"].get<int>();
        double p = single_prob["P"].get<double>();
        assert(int(y) * bayesProb.nodeCnt * bayesProb.flowCnt + int(x) * bayesProb.flowCnt + flow_id < int(bayesProb.P.size()) &&
               int(y) * bayesProb.nodeCnt * bayesProb.flowCnt + int(x) * bayesProb.flowCnt + flow_id >= 0);
        // std::cout << "P: " << int(x) << " " << int(y) << " " << flow_id << " " << p << std::endl;
        bayesProb.set_P(y, x, flow_id, p);
    }
    for (const auto& single_prob: bayesProb_json["Q"]){
        int v = single_prob["v"].get<int>();
        int u = single_prob["u"].get<int>();
        ID s = single_prob["s"].get<ID>();
        double q = single_prob["Q"].get<double>();
        assert(v * bayesProb.flowCnt * bayesProb.nodeCnt + u * bayesProb.nodeCnt + (int)s < int(bayesProb.Q.size()) &&
               v * bayesProb.flowCnt * bayesProb.nodeCnt + u * bayesProb.nodeCnt + (int)s >= 0);
        bayesProb.set_Q(v, u, s, q);
    }

    fin.close();
}
