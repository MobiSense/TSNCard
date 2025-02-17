#include "topo.h"

#include <algorithm>
#include <cctype>
#include <fstream>
#include <iostream>
#include <string>
#include <unordered_map>
#include <unordered_set>
#include <vector>

#include "json.hpp"

extern "C" {
#include "tsn_drivers/gcl.h"
#include "log/log.h"
#include "tsn_drivers/switch_rules.h"
}

using json = nlohmann::json;

std::string to_lower(std::string data) {
    std::transform(data.begin(), data.end(), data.begin(),
                   [](unsigned char c) { return std::tolower(c); });
    return data;
}

json *get_config() {
    static json *j;
    if (j) return j;

    j = new json();
    std::ifstream file("config.json");
    file >> *j;

    for (auto &node : (*j)["nodes"]) {
        node["mac"] = to_lower(node["mac"]);
    }
    return j;
}

json *get_gcl_config() {
    static json *j;
    if (j) return j;

    j = new json();
    std::ifstream file("schedule.json");
    file >> *j;

    for (auto &node : *j) {
        if (node["type"].get<std::string>() == "switch") {
            node["mac"] = to_lower(node["mac"]);
        }
    }

    return j;
}

std::string get_mac_address() {
    std::ifstream file("/sys/class/net/eth0/address");
    std::string mac;
    file >> mac;
    return mac;
}

void setup_topo() {
    json j = *get_config();
    const std::string mac_addr = get_mac_address();

    int id = -1;
    std::string type;

    std::unordered_map<int, std::string> nodes;
    // find current node id, node is either device or switch
    for (auto &node : j["nodes"]) {
        const std::string mac = node["mac"];
        const int node_id = node["id"].get<int>();
        nodes[node_id] = mac;

        if (mac == mac_addr) {
            id = node_id;
            type = node["type"].get<std::string>();
        }
    }

    std::cout << "[INFO] current node is a " << type << " with id " << id
              << std::endl;
    if (id == -1) {
        std::cout << "[ERROR] Could not find node with mac address " << mac_addr
                  << std::endl;
        exit(1);
    }

    // find links whose src is the current node
    for (auto &link : j["fwd"]) {
        const int src = link["src"].get<int>();
        if (src == id) {
            const int src_port = link["src_port"].get<int>();
            const int dst = link["dst"].get<int>();

            if (nodes.find(dst) == nodes.end()) {
                std::cout << "[ERROR] Could not find node with id " << dst
                          << std::endl;
                exit(1);
            }
            std::string dst_mac = nodes[dst];

            std::cout << "switch rule: id/src/port: " << id << "/" << mac_addr
                      << "/" << src_port << " id/dst: " << dst << "/" << dst_mac
                      << std::endl;

            // convert mac address string to uint8 array
            char bytes[6];
            for (int i = 0; i < 6; i++) {
                bytes[i] = std::stoi(dst_mac.substr(i * 3, 2), nullptr, 16);
                std::cout << unsigned(bytes[i]) << " ";
            }

            // // convert dst_mac to char array
            // char bytes[6];
            // if (std::sscanf(dst_mac.c_str(),
            //                 "%02x:%02x:%02x:%02x:%02x:%02x",
            //                 &bytes[0], &bytes[1], &bytes[2],
            //                 &bytes[3], &bytes[4], &bytes[5]) != 6) {
            //     throw std::runtime_error(dst_mac+std::string(" is an invalid
            //     MAC address"));
            // }

            std::cout << std::hex << std::uppercase;
            for (int i = 0; i < 5; i++) {
                std::cout << std::setw(2) << std::setfill('0')
                          << unsigned(bytes[i]) << ":";
            }
            std::cout << std::setw(2) << std::setfill('0')
                      << unsigned(bytes[5]);
            std::cout << std::dec;

            // add link to switch rules
            push_switch_rule(bytes, src_port);
        }
    }
}

// parse and apply gcl for a link
void apply_gcl(json &data, const int port) {
    std::cout << "enter apply_gcl" << std::endl;
    // TODO: make it definition
    const int MAX_PERIOD = 2048;
    const int GCL_SIZE = 16;

    const int from = data["from"].get<int>();
    const int to = data["to"].get<int>();
    std::cout << "gcl: from " << from << " to " << to << std::endl;

    std::vector<int> tt_frames_start_times;
    std::vector<int> time_points{0, MAX_PERIOD};

    for (auto &item : data["schedule"]) {
        const int period = item["period"].get<int>();
        const int start = item["start"].get<int>();
        const int end = item["end"].get<int>();

        if (period == MAX_PERIOD) {
            if (end > MAX_PERIOD) {
                time_points.push_back(0);
                time_points.push_back(end - MAX_PERIOD);
                tt_frames_start_times.push_back(0);
                time_points.push_back(start);
                time_points.push_back(MAX_PERIOD);
                tt_frames_start_times.push_back(start);
            } else {
                time_points.push_back(start);
                time_points.push_back(end);
                tt_frames_start_times.push_back(start);
            }
        } else {
            int x = 0;
            while (x < MAX_PERIOD) {
                if (x + end > MAX_PERIOD) {
                    time_points.push_back(0);
                    time_points.push_back(x + end - MAX_PERIOD);
                    tt_frames_start_times.push_back(0);
                    time_points.push_back(x + start);
                    time_points.push_back(MAX_PERIOD);
                    tt_frames_start_times.push_back(x + start);
                } else {
                    time_points.push_back(x + start);
                    time_points.push_back(x + end);
                    tt_frames_start_times.push_back(x + start);
                }
                x += period;
            }
        }
    }

    // sort and remove duplicates
    std::sort(time_points.begin(), time_points.end());
    time_points.erase(std::unique(time_points.begin(), time_points.end()),
                      time_points.end());

    std::vector<int> gcl_values(GCL_SIZE, 1);
    std::vector<int> gcl_time_intervals(GCL_SIZE, 0);

    int gcl_index = 0;

    for (int i = 0; i < (int)time_points.size(); ++i) {
        int time_point = time_points[i];
        std::cout << time_point;

        if (i == (int)time_points.size() - 1) break;
        //  * reference: IEEE std 802.1Q 2018, page 198. priority 0 or no VLAN -> queue 1, priority 1 -> queue 0.
        if (std::find(tt_frames_start_times.begin(), tt_frames_start_times.end(), time_point) != tt_frames_start_times.end()) {
            std::cout << "===";
            gcl_values[gcl_index] = 1;
            // gcl_values[gcl_index] = 0b011111101; // priority =2
            // gcl_values[gcl_index] = 0b011111111; // priority =2
            gcl_time_intervals[gcl_index] = (time_points[i + 1] - time_point) * 8;
        } else {
            // TODO: add gaurd band mechanism in non-tt frame interval, to protect proceeding tt frames
            std::cout << "---";
            // gcl_values[gcl_index] = 0b011111111; // priority =2
            // gcl_values[gcl_index] = 2;
            gcl_values[gcl_index] = (0b000000010 | 0b100000000);
            gcl_time_intervals[gcl_index] = (time_points[i + 1] - time_point) * 8;
        }
        gcl_index++;
    }
    std::cout << std::endl;

    std::cout << "GCL values: [";
    for (auto &i : gcl_values) std::cout << i << ", ";
    std::cout << "\b\b" << ']' << std::endl;

    std::cout << "GCL times: [";
    for (auto &i : gcl_time_intervals) std::cout << i << ", ";
    std::cout << "\b\b" << ']' << std::endl;

    for (size_t i = 0; i < gcl_values.size(); ++i) {
        set_gcl(port + 1, i, gcl_values[i]);
        set_gcl_time_interval(port + 1, i, uint16_t(gcl_time_intervals[i]));
    }
}

/**
Description: Get GCL values and time intervals.
GCL time interval's time unit is 2^11 ns.
In schedule result, time unit is 2^14 ns. 
If TT flow, GCL value is set to 1 (0x10), which just allows time-triggered frames to pass.
Otherwise, GCL value is set to 2 (0x01), which allows ptp frames or background frames to pass.
*/
void setup_gcl() {
    json j = *get_gcl_config();

    const std::string mac_addr = get_mac_address();
    int id = -1;

    // std::unordered_map<int, std::string> nodes;
    // find current node id, node is either device or switch
    for (auto &item : j) {
        const std::string type = item["type"];
        if (type != "switch") continue;

        const std::string mac = item["mac"];

        if (mac == mac_addr) {
            id = item["id"].get<int>();
            break;
        }
    }

    // id for current switch is not found in schedule, no need to exit.
    if (id == -1) {
        std::cout << "[WARNING] Could not find node with mac address " << mac_addr << "in the schedule"<< std::endl;
        return;
    }

    json topo = *get_config();
    json links = topo["fwd"];

    // mapping: link id -> src port
    std::unordered_map<int, int> link_port_map;
    for (auto &link : links) {
        const int src = link["src"].get<int>();
        if (src != id) continue;

        const int src_port = link["src_port"].get<int>();
        const int link_id = link["id"].get<int>();
        link_port_map[link_id] = src_port;
    }

    // find links whose src is the current node
    for (auto &link : j) {
        const std::string type = link["type"];
        if (type != "link") continue;

        const int src = link["from"].get<int>();
        if (src != id) continue;

        // const int link_id = link["id"].get<int>();
        // if (link_port_map.find(link_id) == link_port_map.end()) {
        //     std::cout << "[ERROR] Could not find link with id " << link_id <<
        //     std::endl; exit(1);
        // }

        // const int src_port = link_port_map[link_id];
        const int src_port = link["from_port"].get<int>();

        apply_gcl(link, src_port);
    }
}

/**
 * description: get the state of the ptp ports
 * return: ptp ports' state. (0: MASTER, 1: SLAVE, 2: PASSIVE, 3: DISABLED)
 * */
void get_ptp_ports(int *ptp_ports) {
    json j = *get_config();

    const std::string mac_addr = get_mac_address();
    int id = -1;

    // std::unordered_map<int, std::string> nodes;
    // find current node id, node is either device or switch
    for (auto &item : j["nodes"]) {
        const std::string type = item["type"];

        if (type != "switch") continue;

        const std::string mac = item["mac"];

        if (mac == mac_addr) {
            id = item["id"].get<int>();

            if (item.find("ptp_ports") != item.end() &&
                item["ptp_ports"].is_array()) {
                auto ports = item["ptp_ports"].get<std::vector<int> >();

                if (ports.size() == 0) return;

                for (int i = 0; i < (int)ports.size(); ++i) {
                    ptp_ports[i] = ports[i];
                    log_debug("ptp ports[%d]: %s", i, lookup_port_state_name((PortState)ptp_ports[i]));
                    // std::cout << "ptp ports[" << i << "]: " << ptp_ports[i] << std::endl;
                }
            }
            break;
        }
    }

    // id for current switch is not found
    if (id == -1) {
        std::cout << "[ERROR] Could not find node with mac address " << mac_addr
                  << std::endl;
        exit(1);
    }
}

/**
 * description: get the clock identity config
 * return: clock identity is a uint8_t array (size: 8)
 * */
void get_clock_identity(ClockIdentity clock_identity) {
    json j = *get_config();

    const std::string mac_addr = get_mac_address();
    int id = -1;

    // std::unordered_map<int, std::string> nodes;
    // find current node id, node is either device or switch
    for (auto &item : j["nodes"]) {
        const std::string type = item["type"];

        if (type != "switch") continue;

        const std::string mac = item["mac"];

        if (mac == mac_addr) {
            id = item["id"].get<int>();

            if (item.find("clock_identity") != item.end() &&
                item["clock_identity"].is_array()) {
                auto clock_identitys = item["clock_identity"].get<std::vector<int> >();

                if (clock_identitys.size() == 0) return;

                for (int i = 0; i < (int)clock_identitys.size(); ++i) {
                    clock_identity[i] = (uint8_t)clock_identitys[i];
                    log_debug("clock_identity[%d]: %d", i, clock_identity[i]);
                }
            }
            break;
        }
    }

    // id for current switch is not found
    if (id == -1) {
        std::cout << "[ERROR] Could not find node with mac address " << mac_addr
                  << std::endl;
        exit(1);
    }
}

/**
 * description: get the priority1
 * return: priority1 is a uint8_t number
 * */
void get_priority1(uint8_t* priority1) {
    json j = *get_config();

    const std::string mac_addr = get_mac_address();
    int id = -1;

    // std::unordered_map<int, std::string> nodes;
    // find current node id, node is either device or switch
    for (auto &item : j["nodes"]) {
        const std::string type = item["type"];

        if (type != "switch") continue;

        const std::string mac = item["mac"];

        if (mac == mac_addr) {
            id = item["id"].get<int>();

            if (item.find("priority1") != item.end()) {
                *priority1 = (uint8_t)item["priority1"];
            }
            break;
        }
    }

    // id for current switch is not found
    if (id == -1) {
        std::cout << "[ERROR] Could not find node with mac address " << mac_addr
                  << std::endl;
        exit(1);
    }
}


/**
 * description: get ptp configurations
 * */
void get_config_from_json(
    SystemIdentity* system_identity,
    int *ptp_ports,
    bool *externalPortConfigurationEnabled)
{
    json j = *get_config();

    const std::string mac_addr = get_mac_address();
    int id = -1;

    for (auto &item : j["nodes"]) {
        const std::string type = item["type"];

        if (type != "switch") continue;

        const std::string mac = item["mac"];

        if (mac == mac_addr) {
            id = item["id"].get<int>();

            if (item.find("ptp_ports") != item.end() && item["ptp_ports"].is_array()) {
                auto ports = item["ptp_ports"].get<std::vector<int> >();

                if (ports.size() == 0) return;

                for (int i = 0; i < (int)ports.size(); ++i) {
                    ptp_ports[i] = ports[i];
                    log_debug("ptp ports[%d]: %s", i, lookup_port_state_name((PortState)ptp_ports[i]));
                }
            }

            if (item.find("externalPortConfigurationEnabled") != item.end()) {
                *externalPortConfigurationEnabled = (bool)item["externalPortConfigurationEnabled"].get<int>(); 
            }

            if (item.find("system_identity") != item.end()) {
                system_identity->priority1               = (uint8_t)item["system_identity"]["priority1"].get<int>();
                system_identity->clockClass              = (uint8_t)item["system_identity"]["clockClass"].get<int>();
                system_identity->clockAccuracy           = (uint8_t)item["system_identity"]["clockAccuracy"].get<int>();
                system_identity->offsetScaledLogVariance = (uint16_t)item["system_identity"]["offsetScaledLogVariance"].get<int>();
                system_identity->priority2               = (uint8_t)item["system_identity"]["priority2"].get<int>();
                
                auto clock_identitys = item["system_identity"]["clock_identity"].get<std::vector<int> >();
                for (int i = 0; i < (int)clock_identitys.size(); ++i) {
                    system_identity->clockIdentity[i] = (uint8_t)clock_identitys[i];
                }
            }

            break;
        }
    }

    // id for current switch is not found
    if (id == -1) {
        std::cout << "[ERROR] Could not find node with mac address " << mac_addr
                  << std::endl;
        exit(1);
    }
}