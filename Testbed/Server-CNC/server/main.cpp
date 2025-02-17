#include <arpa/inet.h>
#include <dirent.h>
#include <netinet/in.h>
#include <sys/socket.h>
#include <unistd.h>

#include <algorithm>
#include <chrono>
#include <cmath>
#include <cstdlib>
#include <fstream>
#include <iostream>
#include <map>
#include <sstream>
#include <string>
#include <thread>
#include <unordered_map>
#include <unordered_set>
#include <vector>
#include <random>

#include "../Utils/SafeQueue.hpp"
#include "../Utils/json.hpp"
#include "../Utils/message.hpp"
#include "../Utils/utils.hpp"
#include "dataloader.h"
#include "flow.hpp"
#include "bayes.hpp"

using namespace std;
using json = nlohmann::json;

const bool USESIM      = true; // whether to use simulation data
const bool USEBAYES    = true; // whether to use bayes to guide the searching progress
bool EVENDIST    = false;
bool RANDDIST    = false;
bool ALLGET      = false;
bool GREEDY      = false;

SafeQueue<int> misbehavior_queue;
int misbehavior_sockfd;
int debug_sockfd;
int ts_sockfd;
unordered_map<ID, string> ID2PSIP;

int bandwidth_threshold = 1000;         // unit: Kbps
const int FLOWMAXNUM = 1024;
const int PROBE_PACKET_SIZE = 64 * 8;   // unit: bit
const int POSTCARD_PERIOD = 4;          // period for postcard transmission, unit: ms
string latest_log_name = "";

SEARCHITEM flow_queue[FLOWMAXNUM];      // searching queue
unordered_set<int> in_queue;
vector<ID> node_list;
map<int, FLOW> flows;                   // record flow configuration
unordered_map<LINK, int> linkCnt;       // count how many flows go through each link
unordered_map<int, FLOWLOG> flow_logs;  // record postcards
unordered_map<int, LINK> flow_err;      // record the first error link on each flow
unordered_map<LINK, int> errorPoll;     // how many flows believe this link is the root cause
BayesProb* bayesProb = nullptr;
// double bayes_P[256][256][256];
// double bayes_Q[256][256][256];

void init_socket();
void recv_misbehavior();
void notify_misbehavior(int);
// bool find_root_cause(int, int, ID&);
bool find_root_cause_offline(int, int, int, const BayesProb&, ID&, vector<int>&);

bool contains(const vector<ID>& v, ID x) {
    for (ID y: v) if (x == y) return true;
    return false;
}

int get_postcards_cnt(const map<int, FLOW>& flows) {
    int ret = 0;
    for (const auto& it: flows) {
        ret += it.second.path.size();
    }
    return ret;
}

int main(int argc, char* argv[]) {
    // load_latest_log_data(flow_logs, latest_log_name);
    // read_global_configuration(flows, linkCnt, latest_log_name);

    // // output_postcards(flows, flow_logs, 10);
    // output_line_delay(flows, flow_logs, 100);
    DIR *dir;
    struct dirent *ent;
    std::string path = "logs/new_simulation_log/Ring6-10";

    if (argc > 1) {
        path = "logs/new_simulation_log/" + std::string(argv[1]);
        // std::cout << path << std::endl;
    }
    if (argc > 2) {
        bandwidth_threshold = std::atoi(argv[2]);
    }
    
    if (argc > 3) {
        std::string t = std::string(argv[3]);
        if (t == "even") {
            EVENDIST    = true;
        } else
        if (t == "random") {
            RANDDIST    = true;
        } else
        if (t == "woband") {
            ALLGET      = true;
        } else
        if (t == "greedy") {
            GREEDY      = true;
        }
    }

    if ((dir = opendir(path.c_str())) != NULL) {
        while ((ent = readdir(dir)) != NULL) {
            std::string name = ent->d_name;
            if (name == "." || name == "..") {
                continue;  // Skip . and ..
            }
            // std::cout << name << std::endl;
            // if (name != "new_log_1700543920105.json") continue;
            std::string fullpath = path + "/" + name;
            std::cout << fullpath << std::endl;

            node_list.clear();
            flows.clear();
            linkCnt.clear();
            flow_logs.clear();
            vector<ID> root_cause_nodes;
            int flow_id, pkt_id;

            read_simulation_data(fullpath, node_list, flows, linkCnt, flow_logs,
                                 root_cause_nodes, flow_id, pkt_id);

            // cout << node_list.size() << " nodes and " << flow_logs.size() << " flows in total" << endl;

            bayesProb = new BayesProb(node_list.size(), flow_logs.size());
            read_bayes_result(*bayesProb);

            // output_postcards(flows, flow_logs);
            
            ID error_node0, error_node1, error_node2;
            // int postcards_cnt0, postcards_cnt1, postcards_cnt2;
            // int total_latency0, total_latency1, total_latency2;
            vector<int> postcards_cnt0, postcards_cnt1, postcards_cnt2;
            bool res0, res1, res2;
            res0 = find_root_cause_offline(flow_id, 0, bandwidth_threshold, *bayesProb, error_node0, postcards_cnt0);
            res1 = find_root_cause_offline(flow_id, 1, bandwidth_threshold, *bayesProb, error_node1, postcards_cnt1);
            res2 = find_root_cause_offline(flow_id, 2, bandwidth_threshold, *bayesProb, error_node2, postcards_cnt2);
            if (!res0 && !res1 && !res2) {
                cout << "Failed to find the root cause node!" << endl;
            } else
            if (res0 && contains(root_cause_nodes, error_node0)) {
                cout << "Succeed in finding the root cause at #" << int(error_node0) << ", with total postcard " << get_postcards_cnt(flows) << ", with ours cnt ";
                for (int x: postcards_cnt0) cout << x << " ";
                cout << endl;
            } else
            if (res1 && contains(root_cause_nodes, error_node1)) {
                cout << "Succeed in finding the root cause at #" << int(error_node1) << ", with total postcard " << get_postcards_cnt(flows) << ", with ours cnt ";
                for (int x: postcards_cnt1) cout << x << " ";
                cout << endl;
            } else
            if (res2 && contains(root_cause_nodes, error_node2)) {
                cout << "Succeed in finding the root cause at #" << int(error_node2) << ", with total postcard " << get_postcards_cnt(flows) << ", with ours cnt ";
                for (int x: postcards_cnt2) cout << x << " ";
                cout << endl;
            } else
            {
                cout << "root cause is ";
                for (ID x: root_cause_nodes) cout << int(x) << ", ";
                cout << "but find the node " << int(error_node0) << "(0), "
                     << int(error_node1) << "(1), "
                     << int(error_node2) << "(2), "
                     << " mistakenly! pkt_id = " << pkt_id << endl;
            }

            // ID error_node;
            // if (!find_root_cause_offline(flow_id, pkt_id + 1, bandwidth_threshold, *bayesProb, error_node))
            //     cout << "Failed to find the root cause node!" << endl;
            // else {
            //     if (contains(root_cause_nodes, error_node)) {
            //         cout << "Succeed in finding the root cause at #" << int(error_node) <<  "!" << endl;
            //     } else
            //     {
            //         cout << "root cause is ";
            //         for (ID x: root_cause_nodes) cout << int(x) << ", ";
            //         cout << "but find the node " << int(error_node) << " mistakenly! pkt_id = " << pkt_id << endl;
            //     }
            // }

            delete bayesProb;
        }
        closedir(dir);
    }

    // if (USESIM) {
    //     read_simulation_data(node_list, flows, linkCnt, flow_logs);
    // } else
    // {
    //     load_latest_log_data(flow_logs, latest_log_name);
    //     read_global_configuration(flows, linkCnt, latest_log_name);
    // }

    // if (USESIM) {
    //     bayesProb = new BayesProb(node_list.size(), flow_logs.size());
    //     read_bayes_result(*bayesProb);
    // }

    // // output_postcards(flows, flow_logs);

    // int flow_id, pkt_id;
    // cin >> flow_id >> pkt_id;
    // ID error_node;
    // if (!find_root_cause_offline(flow_id, pkt_id, bandwidth_threshold, *bayesProb, error_node))
    //     cout << "Failed to find the crashed node!" << endl;
    // cout << "Error node: " << (int)error_node << endl;

    return 0;
}

void init_socket() {
    // misbehavior socket: receive misbehavior report from devices
    struct sockaddr_in misbahavior_recv_addr;
    if ((misbehavior_sockfd = socket(AF_INET, SOCK_DGRAM, 0)) < 0) {
        perror("misbehavior socket creation failed!");
        exit(EXIT_FAILURE);
    }

    memset(&misbahavior_recv_addr, 0, sizeof(misbahavior_recv_addr));
    misbahavior_recv_addr.sin_family = AF_INET;
    misbahavior_recv_addr.sin_addr.s_addr = INADDR_ANY;
    misbahavior_recv_addr.sin_port = htons(MisbehaviorPort);

    if (bind(misbehavior_sockfd, (const struct sockaddr*)&misbahavior_recv_addr,
             sizeof(misbahavior_recv_addr)) < 0) {
        perror("misbehavior socket bind failed!");
        exit(EXIT_FAILURE);
    }

    // debug socket: send debug notification to devices and switches
    if ((debug_sockfd = socket(AF_INET, SOCK_DGRAM, 0)) < 0) {
        perror("debug socket creation failed");
        exit(EXIT_FAILURE);
    }

    // timestamp socket: collect timestamps from switches
    struct sockaddr_in ts_recv_addr;
    if ((ts_sockfd = socket(AF_INET, SOCK_DGRAM, 0)) < 0) {
        perror("timestamp socket creation failed!");
        exit(EXIT_FAILURE);
    }

    memset(&ts_recv_addr, 0, sizeof(ts_recv_addr));
    ts_recv_addr.sin_family = AF_INET;
    ts_recv_addr.sin_addr.s_addr = INADDR_ANY;
    ts_recv_addr.sin_port = htons(TSPort);

    if (bind(ts_sockfd, (const struct sockaddr*)&ts_recv_addr,
             sizeof(ts_recv_addr)) < 0) {
        perror("timestamp socket bind failed!");
        exit(EXIT_FAILURE);
    }
}

void recv_misbehavior() {
    // receive misbehavior from dst of flow #flow_id
    char msg[100];
    struct sockaddr_in addr;

    memset(&addr, 0, sizeof(addr));

    while (true) {
        int n = ycdfwzy::recv(msg, misbehavior_sockfd, &addr);
        if (n > 0) {
            int flow_id = atoi(msg);
            misbehavior_queue.push(flow_id);
        }
    }
}

void notify_misbehavior(int flow_id) {
    // send an packet to notify dst to enable

    struct sockaddr_in addr;
    memset(&addr, 0, sizeof(addr));

    addr.sin_family = AF_INET;
    addr.sin_addr.s_addr =
        inet_addr(ID2PSIP[flows[flow_id].get_src_id()].c_str());
    addr.sin_port = htons(DebugPort);

    ycdfwzy::send(enable_debug_msg.c_str(), debug_sockfd, &addr);
}

// the node x on flow #flow_id has misbehavior
// select k nodes between [start_id, end_id) on flow #flow_id
void select_switches(int flow_id, ID x, ID start_id, ID end_id, int k,
                     const BayesProb& bayesProb,
                     vector<ID>& selected_switches, bool usebayes = false) {
    const FLOW& flow = flows[flow_id];
    size_t start_index = flow.get_index(start_id);
    size_t end_index = flow.get_index(end_id);
    selected_switches.clear();

    // cout << start_index << " " << end_index << " " << k << endl;

    assert(k >= 1);
    assert(start_index < end_index);

    // we assume the start device of one flow always behave normally
    // if (start_id == flows[flow_id].get_src_id()) start_index++;

    if (EVENDIST) {
        // even distribute
        // start_index++;
        // selected_switches.emplace_back(start_id);

        // int total_candidate_nodes = end_index - start_index - 1;
        int total_candidate_nodes = end_index - start_index;
        int inc = total_candidate_nodes / (k + 1);
        int app = total_candidate_nodes % (k + 1);
        // for (size_t i = start_index + inc + (app > 0); i < end_index; i += inc + (app >= 0)) {
        for (size_t i = start_index; i < end_index; i += inc + (app >= 0)) {
            selected_switches.emplace_back(flow.path[i].from_id);
            app--;
        }
    } else
    if (RANDDIST) {
        // random select
        vector<size_t> ids;
        for (size_t i = start_index + 1; i < end_index; i++)
            ids.emplace_back(i);

        // 创建一个随机数生成器
        std::random_device rd;
        std::mt19937 g(rd());

        // 打乱数组
        std::shuffle(ids.begin(), ids.end(), g);
        sort(ids.begin(), k - 1 < int(ids.size()) ? ids.begin() + (k - 1) : ids.end());

        selected_switches.emplace_back(start_id);
        for (int i = 0; i < k - 1 && i < int(ids.size()); i++) {
            selected_switches.emplace_back(flow.path[ids[i]].from_id);
        }
    } else
    if (GREEDY) {
        vector<size_t> ids;
        for (size_t i = start_index + 1; i < end_index; i++)
            ids.emplace_back(i);

        sort(ids.begin(), ids.end(), [&flow](size_t a, size_t b) {
            return linkCnt[linkConvertor(flow.path[a].from_id, flow.path[a].to_id)] > 
                    linkCnt[linkConvertor(flow.path[b].from_id, flow.path[b].to_id)];
        });
        sort(ids.begin(), k - 1 < int(ids.size()) ? ids.begin() + (k - 1) : ids.end());

        selected_switches.emplace_back(start_id);
        for (int i = 0; i < k - 1 && i < int(ids.size()); i++)
            selected_switches.emplace_back(flow.path[ids[i]].from_id);
    } else
    if (ALLGET) {
        // get all on this flow
        for (size_t i = start_index; i < end_index; i++)
            selected_switches.emplace_back(flow.path[i].from_id);
    } else
    if (usebayes) {
        vector<size_t> ids;
        // bayes guided switch selection
        for (size_t i = start_index + 1; i < end_index; i++)
            ids.emplace_back(i);
        sort(ids.begin(), ids.end(), [x, flow_id, &bayesProb, &flow](size_t a, size_t b) {
            return bayesProb.get_P(flow.path[a].from_id, x, flow_id) > 
                    bayesProb.get_P(flow.path[b].from_id, x, flow_id);
        });
        sort(ids.begin(), k - 1 < int(ids.size()) ? ids.begin() + (k - 1) : ids.end());
        selected_switches.emplace_back(start_id);
        for (int i = 0; i < k - 1 && i < int(ids.size()); i++)
            selected_switches.emplace_back(flow.path[ids[i]].from_id);
        // sort(selected_switches.begin(), selected_switches.end());
    } else 
        exit(1);
}

// double get_similarity(const vector<TIMESTAMP>& ts_data, int start_index,
//                       int len, const vector<ID>& path) {
//     int matched_nodes_cnt = 0;
//     for (ID node : path) {
//         bool matched = false;
//         for (int i = 0; i < len; i++) {
//             if (node == ts_data[start_index + i].switch_id) {
//                 matched = true;
//                 break;
//             }
//         }
//         if (matched)
//             matched_nodes_cnt++;
//         else {
//             matched_nodes_cnt = 0;
//             break;
//         }
//     }
//     return (double)matched_nodes_cnt / path.size();
// }

// void sort_flow_out(vector<TIMESTAMP>& ts_data,
//                    const map<int, vector<ID>>& selected_switches,
//                    map<int, vector<TIMESTAMP>>& sorted_ts_data) {
//     // classify according to packet
//     sort(ts_data.begin(), ts_data.end(),
//          [](const TIMESTAMP& a, const TIMESTAMP& b) { return a.md5 < b.md5; });

//     int L = ts_data.size();
//     int i = 0;
//     while (i < L) {
//         int k = 0;
//         while ((i + k < L) && ts_data[i + k].md5 == ts_data[i].md5) k++;

//         double max_similarity = 0.;
//         int max_flow_id;
//         for (const auto& it : selected_switches) {
//             int flow_id = it.first;
//             if (sorted_ts_data.find(flow_id) != sorted_ts_data.end()) continue;
//             double similarity = get_similarity(ts_data, i, k, it.second);
//             if (similarity > max_similarity) {
//                 max_similarity = similarity;
//                 max_flow_id = flow_id;
//             }
//         }
//         assert(max_similarity > 1e-6);

//         // sort timestamps according to flow path order
//         sorted_ts_data[max_flow_id].clear();
//         const vector<ID>& path = selected_switches.find(max_flow_id)->second;
//         for (ID node : path) {
//             for (int j = i; j < i + k; j++)
//                 if (node == ts_data[j].switch_id) {
//                     sorted_ts_data[max_flow_id].emplace_back(ts_data[j]);
//                     break;
//                 }
//         }

//         i += k;
//     }
// }

const uint64_t deviation_threshold = 2000;  // 2us
// const uint64_t fwd_delay = uint64_t(Scale * 0.75);

static bool periods_late(UScaledNs ts, UScaledNs last_ts, UScaledNs period = Period) {
    // return !(ts >= last_ts && (ts - last_ts) < period);
    if (ts < last_ts) return false;
    return ts - last_ts > period;
}

static bool too_early(UScaledNs scheduled_ts, UScaledNs real_ts, UScaledNs period = Period) {
    real_ts = real_ts % period;
    return real_ts < scheduled_ts &&
           deviation_threshold < scheduled_ts - real_ts;
}

static bool too_late(UScaledNs scheduled_ts, UScaledNs real_ts, UScaledNs period = Period) {
    real_ts = real_ts % period;
    return scheduled_ts <= real_ts &&
           deviation_threshold < real_ts - scheduled_ts;
}

DiagRes analyze_timestamp(int flow_id, const TIMESTAMP& ts,
                          const TIMESTAMP& last_ts) {
    const auto& flow = flows[flow_id];
    const UScaledNs period = flow.path.back().period;
    UScaledNs scheduled_rx = flow.get_scheduled_rx_ts(ts.switch_id);
    UScaledNs scheduled_tx = flow.get_scheduled_tx_ts(ts.switch_id);
    if (flow.get_src_id() != ts.switch_id) {
        // note: use last_ts.tx, since the second node(the first switch) will access the src's rx, which is an invalid value
        if (periods_late(ts.rx, last_ts.tx, period)) return Periods_Late_Ingress;
        if (too_early(scheduled_rx, ts.rx, period)) return Early_Ingress;
        if (too_late(scheduled_rx, ts.rx, period)) return Late_Ingress;
    }
    if (flow.get_dst_id() != ts.switch_id) {
        if (periods_late(ts.tx, last_ts.tx, period)) return Periods_Late_Egress;
        if (too_early(scheduled_tx, ts.tx, period)) return Early_Egress;
        if (too_late(scheduled_tx, ts.tx, period)) return Late_Egress;
    }
    return Normal;
}

void narrow_down_scope(const map<int, vector<TIMESTAMP>>& sorted_ts_data,
                       const map<int, vector<ID>>& selected_switches,
                       SEARCHITEM* flow_list, int len) {
    for (int i = 0; i < len; i++) {
        int flow_id = flow_list[i].flow_id;
        const vector<TIMESTAMP>& ts_data = sorted_ts_data.find(flow_id)->second;
        const vector<ID>& path = selected_switches.find(flow_id)->second;

        bool narrowed = false;
        int len = path.size();
        // j is the index of path, while k is the index of ts_data
        // traverse all timestamp data according to the path order
        for (int j = 0, k = 0; j < len && !narrowed; j++) {
            // packet loss at j
            if (k >= int(ts_data.size()) || path[j] != ts_data[k].switch_id) {
                flow_list[i].start_id = path[j];
                if (j + 1 < len) flow_list[i].end_id = path[j + 1];
                narrowed = true;
                k++;
                continue;
            }
            // maybe the first tx of this path is the better choice of last_ts
            DiagRes analyze_result = analyze_timestamp(flow_id, ts_data.at(k), ts_data.at(k == 0 ? k : k - 1));
            switch (analyze_result) {
                case Early_Ingress:
                case Late_Ingress:
                case Periods_Late_Ingress:
                    flow_list[i].end_id = ts_data.at(k).switch_id;
                    if (k > 0) flow_list[i].start_id = ts_data.at(k - 1).switch_id;
                    narrowed = true;
                    break;
                case Early_Egress:
                case Late_Egress:
                case Periods_Late_Egress:
                    flow_list[i].start_id = path.at(j);
                    if (j + 1 < len) flow_list[i].end_id = path.at(j+1);
                    // flow_list[i].start_id = ts_data.at(k).switch_id;
                    // if (k + 1 < int(ts_data.size()))
                    //     flow_list[i].end_id = ts_data.at(k + 1).switch_id;
                    narrowed = true;
                    break;
                case Packet_Loss:
                    // some data on this path are missing, two possible
                    // causes
                    //   1. packet loss on this path
                    //   2. packet loss between switch and server

                    // if (k >= ts_data.size()) {
                    //     // the second cause
                    //     // ACTION: do not take this switch into consideration
                    //     k--;
                    // } else 
                    // {
                        // the first cause
                        // ACTION: localize the error node
                        assert(k > 0);
                        flow_list[i].start_id = ts_data.at(k - 1).switch_id;
                        flow_list[i].end_id = ts_data.at(k).switch_id;
                        // flow_list[i].start_id = ts_data.at(k).switch_id;
                        // if (k + 1 < int(ts_data.size()))
                        //     flow_list[i].end_id = ts_data.at(k + 1).switch_id;
                        narrowed = true;
                    // }
                    break;
                default:
                    break;
            }
            k++;
        }
        if (!narrowed) {
            flow_list[i].start_id = ts_data.back().switch_id;
        }
    }
}

bool error_localized(SEARCHITEM* flow_list, int len) {
    for (int i = 0; i < len; i++) {
        assert(flow_list[i].start_id != flow_list[i].end_id);
        if (!flows[flow_list[i].flow_id].has_link(flow_list[i].start_id,
                                                  flow_list[i].end_id))
            return false;
    }
    return true;
}

void set_debug_mode(const ID& switch_id, int mode) {
    struct sockaddr_in addr;
    memset(&addr, 0, sizeof(addr));

    addr.sin_family = AF_INET;
    addr.sin_addr.s_addr = inet_addr(ID2PSIP[switch_id].c_str());
    addr.sin_port = htons(DebugPort);

    ycdfwzy::send(
        mode == 1 ? enable_debug_msg.c_str() : disable_debug_msg.c_str(),
        debug_sockfd, &addr);
}


// flow #flow_u has misbehavior at node s
// sort the to-be-searched flows according to its Q
void sort_flow_heuristically(int l, int r, int flow_u, ID s, const BayesProb& bayesProb, bool usebayes = false) {
    if (usebayes) {
        // bayes guided flow selection
        // Q[u][v][x]
        sort(flow_queue + l, flow_queue + r + 1, [flow_u, s, &bayesProb](const SEARCHITEM& v1, const SEARCHITEM& v2) {
            return bayesProb.get_Q(v1.flow_id, flow_u, s) > bayesProb.get_Q(v2.flow_id, flow_u, s);
        });
    } else
    {
        // assuming all nodes have the same possibility to crash down
        //   we prefer to search longer flow first
        sort(flow_queue + l, flow_queue + r + 1,
            [&](const SEARCHITEM& a, const SEARCHITEM& b) {
                return flows[a.flow_id].get_index(a.end_id) -
                            flows[a.flow_id].get_index(a.start_id) >
                        flows[b.flow_id].get_index(b.end_id) -
                            flows[b.flow_id].get_index(b.start_id);
            });
    }
}

void collect_timestamp_data(vector<TIMESTAMP>& ts_data) {
    char msg[100];
    struct sockaddr_in addr;
    // collect ts data for 1 seconds
    auto start = std::chrono::high_resolution_clock::now();

    while (true) {
        // Check the time difference from now and start.
        auto end = std::chrono::high_resolution_clock::now();
        auto elapsed = std::chrono::duration_cast<std::chrono::milliseconds>(end - start);

        // If one second has passed, break the loop.
        if (elapsed.count() >= 1000) {
            break;
        }

        // receive timestamps
        memset(&addr, 0, sizeof(addr));
        int n = ycdfwzy::recv(msg, ts_sockfd, &addr);
        if (n > 0) {
            TIMESTAMP ts;
            // convert char* to int
            ts.rx = convert_hex(msg, 16);
            ts.tx = convert_hex(msg + 16, 16);
            ts.md5.md5[0] = convert_hex(msg + 32, 16);
            ts.md5.md5[1] = convert_hex(msg + 48, 16);
            ts.switch_id = convert_hex(msg + 64, 2);
            ts_data.emplace_back(ts);
        }

        // Wait for 100 milliseconds before the next operation.
        // Adjust this value according to your needs.
        // std::this_thread::sleep_for(std::chrono::milliseconds(100));
    }
}

void collect_timestamp_data_from_file(map<int, vector<ID>>& selected_switches, int pkt_id,
                                      map<int, vector<TIMESTAMP>>& ts_data) {
    for (const auto& it : selected_switches) {
        int flow_id = it.first;
        const vector<ID>& host_ids = it.second;
        vector<TIMESTAMP>& ts_list = ts_data[flow_id];

        for (ID host_id : host_ids) {
            if (has_ts(flow_logs, flow_id, pkt_id, host_id)) {
                TIMESTAMP& ts = get_ts(flow_logs, flow_id, pkt_id, host_id, false);
                ts_list.emplace_back(ts);
            }
        }
    }
}

// bool search(int l, int r, int bandwidth_threshold, ID& error_node) {
//     // k: search k flows simultaneously
//     // s: enable s switches debug mode
//     int k, s;
//     map<int, vector<ID>> selected_switches;
//     // calc proper k
//     k = max(int(sqrt(bandwidth_threshold / PROBE_PACKET_SIZE)), 1);
//     for (int i = l; i <= r; i += k) {
//         int t = min(r - i + 1, k);
//         // calc proper s
//         s = bandwidth_threshold / PROBE_PACKET_SIZE / t;

//         while (!error_localized(flow_queue + i, min(k, r - i + 1))) {
//             for (int j = i; j <= r && j < i + k; j++) {
//                 int flow_id = flow_queue[j].flow_id;
//                 selected_switches[flow_id].clear();
//                 select_switches(flow_id, flow_queue[j].start_id,
//                                 flow_queue[j].end_id, s,
//                                 selected_switches[flow_id]);
//             }
//             // enable debug mode
//             for (const auto& it : selected_switches)
//                 for (const ID& switch_id : it.second)
//                     set_debug_mode(switch_id, 1);

//             vector<TIMESTAMP> ts_data;
//             map<int, vector<TIMESTAMP>> sorted_ts_data;
//             // get all packets
//             collect_timestamp_data(ts_data);
//             // classify data according to flow id
//             //     classify data according to md5(packet)
//             //     for each flow, find the best match packets set
//             // sort_flow_out(ts_data, selected_switches, sorted_ts_data);
//             // get the first broken-down switches
//             // narrow down the search scope
//             narrow_down_scope(sorted_ts_data, selected_switches, flow_queue + i,
//                               min(k, r - i + 1));

//             // disable debug mode
//             for (const auto& it : selected_switches)
//                 for (const ID& switch_id : it.second)
//                     set_debug_mode(switch_id, 0);
//         }

//         for (int j = i; j <= r && j < i + k; j++) {
//             LINK link =
//                 linkConvertor(flow_queue[j].start_id, flow_queue[j].end_id);
//             errorPoll[link]++;
//             // if all flows think this link is the root cause,
//             // then we find it!
//             if (errorPoll[link] == linkCnt[link]) {
//                 error_node = (link >> 8);
//                 return true;
//             }
//         }

//         // dfs
//         int tmp_l = r + 1;
//         int tmp_r = r;
//         for (int j = i; j <= r && j < i + k; j++) {
//             for (const auto& it : flows)
//                 if (in_queue.find(it.second.flow_id) == in_queue.end() &&
//                     it.second.has_link(flow_queue[j].start_id,
//                                        flow_queue[j].end_id)) {
//                     tmp_r++;
//                     flow_queue[tmp_r].flow_id = it.second.flow_id;
//                     flow_queue[tmp_r].start_id = it.second.get_src_id();
//                     flow_queue[tmp_r].end_id = flow_queue[j].end_id;
//                     in_queue.insert(it.second.flow_id);
//                 }
//         }
//         sort_flow_heuristically(tmp_l, tmp_r);
//         if (search(tmp_l, tmp_r, bandwidth_threshold, error_node)) return true;
//     }
//     return false;
// }

// bool find_root_cause(int flow_id, int bandwidth_threshold, ID& error_node) {
//     ID start_id = flows[flow_id].get_src_id();
//     ID end_id = flows[flow_id].get_dst_id();
//     flow_queue[0].flow_id = flow_id;
//     flow_queue[0].start_id = start_id;
//     flow_queue[0].end_id = end_id;
//     errorPoll.clear();
//     in_queue.clear();
//     in_queue.insert(flow_id);

//     return search(0, 0, bandwidth_threshold, error_node);
// }

void search_iteration(int i, int t, int s, int pkt_id, const BayesProb& bayesProb,
                      vector<int>& postcards_cnt) {
    map<int, vector<ID>> selected_switches;
    for (int j = i; j < i + t; j++) {
        int flow_id = flow_queue[j].flow_id;
        selected_switches[flow_id].clear();
        select_switches(flow_id, flow_queue[j].end_id,
                        flow_queue[j].start_id,
                        flow_queue[j].end_id, s,
                        bayesProb,
                        selected_switches[flow_id],
                        USEBAYES);
    }

    map<int, vector<TIMESTAMP>> sorted_ts_data;
    sorted_ts_data.clear();
    collect_timestamp_data_from_file(selected_switches, pkt_id, sorted_ts_data);

    int tmp_cnt = 0;
    for (const auto& ts_data: sorted_ts_data)
        // tmp_cnt += int(ts_data.second.size()) - 1; // remove the first postcard
        tmp_cnt += int(ts_data.second.size());
    postcards_cnt.emplace_back(tmp_cnt);

    // get the first broken-down switches / devices
    // narrow down the search scope
    narrow_down_scope(sorted_ts_data, selected_switches, flow_queue + i, t);
}

bool search_offline(int l, int r, int pkt_id, int bandwidth_threshold,
                    const BayesProb& bayesProb, ID& error_node,
                    vector<int>& postcards_cnt) {
    // cout << "seaching: " << endl;
    // for (int i = l; i <= r; i++) {
    //     cout << flow_queue[i].flow_id << " " << (int)flow_queue[i].start_id << " " << (int)flow_queue[i].end_id << endl;
    // }

    // k: search k flows simultaneously
    // s: enable s switches debug mode
    int k, s;
    // map<int, vector<ID>> selected_switches;
    // calc proper k, we set actual period as 8ms
    k = max(int(sqrt(bandwidth_threshold * POSTCARD_PERIOD / PROBE_PACKET_SIZE)), 1);
    k = min(k, 3);
    for (int i = l; i <= r; i += k) {
        int t = min(r - i + 1, k);
        // calc proper s
        s = max((bandwidth_threshold * POSTCARD_PERIOD / PROBE_PACKET_SIZE - 1) / t + 1, 1);
        // s = max(bandwidth_threshold * POSTCARD_PERIOD / PROBE_PACKET_SIZE, 1);

        search_iteration(i, t, s, pkt_id, bayesProb, postcards_cnt);
        while (!error_localized(flow_queue + i, t))
            search_iteration(i, t, s, pkt_id, bayesProb, postcards_cnt);

        for (int j = i; j < i + t; j++) {
            // cout << "located: " << flow_queue[j].flow_id << ": " << int(flow_queue[j].start_id) << "~" << int(flow_queue[j].end_id) << endl;
            LINK link = linkConvertor(flow_queue[j].start_id, flow_queue[j].end_id);
            flow_err[flow_queue[j].flow_id] = link;

            errorPoll[link]++;
            // if all flows think this link is the root cause, then we find it!
            if (errorPoll[link] == linkCnt[link]) {
                error_node = (link >> 8);
                return true;
            }
        }

        // dfs
        int tmp_l = r + 1;
        int tmp_r = r;
        for (int j = i; j < i + t; j++) {
            int last_tmp_r = tmp_r;
            for (const auto& it : flows)
                if (in_queue.find(it.second.flow_id) == in_queue.end() &&
                    it.second.has_link(flow_queue[j].start_id, flow_queue[j].end_id)) {
                    tmp_r++;
                    flow_queue[tmp_r].flow_id = it.second.flow_id;
                    flow_queue[tmp_r].start_id = it.second.get_src_id();
                    flow_queue[tmp_r].end_id = flow_queue[j].end_id;
                    in_queue.insert(it.second.flow_id);
                } else
                if (flow_err.find(it.second.flow_id) != flow_err.end() &&
                    it.second.has_link(flow_queue[j].start_id, flow_queue[j].end_id)) {
                    // this flow has been searched
                    // this flow thinks this
                    ID tmp_node = (flow_err[it.second.flow_id] >> 8);
                    
                    size_t idx0 = it.second.get_index(flow_queue[j].start_id);
                    size_t idx1 = it.second.get_index(tmp_node);
                    if (idx0 < idx1) {
                        LINK link = linkConvertor(flow_queue[j].start_id, flow_queue[j].end_id);
                        errorPoll[link]++;
                        if (errorPoll[link] == linkCnt[link]) {
                            error_node = (link >> 8);
                            return true;
                        }
                    } else
                    if (idx0 > idx1) {
                        LINK link = flow_err[it.second.flow_id];
                        errorPoll[link]++;
                        if (errorPoll[link] == linkCnt[link]) {
                            error_node = (link >> 8);
                            return true;
                        }
                    }
                }
            sort_flow_heuristically(last_tmp_r + 1, tmp_r,
                                    flow_queue[j].flow_id,
                                    flow_queue[j].end_id,
                                    bayesProb, USEBAYES);
        }
        // sort_flow_heuristically(tmp_l, tmp_r);
        if (search_offline(tmp_l, tmp_r, pkt_id, bandwidth_threshold, bayesProb, error_node, postcards_cnt))
            return true;
    }
    return false;
}

bool find_root_cause_offline(int flow_id, int pkt_id, int bandwidth_threshold,
                             const BayesProb& bayesProb, ID& error_node,
                             vector<int>& postcards_cnt) {
    ID start_id = flows[flow_id].get_src_id();
    ID end_id = flows[flow_id].get_dst_id();
    flow_queue[0].flow_id = flow_id;
    flow_queue[0].start_id = start_id;
    flow_queue[0].end_id = end_id;
    errorPoll.clear();
    flow_err.clear();
    in_queue.clear();
    in_queue.insert(flow_id);
    postcards_cnt.clear();

    return search_offline(0, 0, pkt_id, bandwidth_threshold, bayesProb, error_node, postcards_cnt);
}
