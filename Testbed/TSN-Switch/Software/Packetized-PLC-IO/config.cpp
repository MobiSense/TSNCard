#include <iostream>
#include <fstream>
#include <string>
#include <algorithm>
#include <unordered_map>
#include <unordered_set>

#include "config.h"
#include "json.hpp"

using json = nlohmann::json;
using namespace std;

int INPUT_STREAM_NUM = 0;
std::vector<uint32_t> input_seq_ids;
int OUTPUT_STREAM_NUM = 0;
std::vector<uint32_t> output_seq_ids;
std::vector<char*> output_dst_addresses;
char* output_src_address;
uint32_t CYCLE_TIME = 0;
uint32_t COMPUTE_OFFSET = 0;
uint32_t COMPUTE_TIME = 0;

string toUpper(const string& s) {
	string ret = s;
	int n = s.length();
	for (int i = 0; i < n; i++) {
		if (ret[i] >= 'a' && ret[i] <= 'z')
			ret[i] = ret[i] - 'a' + 'A';
	}
	return ret;
}

json* get_topo() {
    static json *topo;
    if (topo) return topo;

    topo = new json();
    std::ifstream file("config.json");
    file >> *topo;
    return topo;
}

json* get_schedule() {
    static json *schedule;
    if (schedule) return schedule;

    schedule = new json();
    std::ifstream file("schedule.json");
    file >> *schedule;
    return schedule;
}

string get_mac_address() {
    ifstream file("/sys/class/net/eth0/address");
    string mac;
    file >> mac;
    return toUpper(mac);
    // return "00:0A:35:00:01:53"; // switch3
}

class MacAddr {
public:
    MacAddr(const string& addr) {
        string s = addr;
        string::size_type p;
        for (int i = 0; i < 6; i++) {
            this->addr[i] = char(stoi(s, &p, 16));
            assert(addr[p] == ':' && p == 2);
            if (i < 5) s = s.substr(p+1);
        }
    }

    char* get_addr() { return addr; }

    friend ostream& operator <<(ostream& os, const MacAddr& maddr) {
        os << hex << uppercase;
        for (int i = 0; i < 5; i++) {
            os << setw(2) << setfill('0') << unsigned(maddr.addr[i]) << ":";
        }
        os << setw(2) << setfill('0') << unsigned(maddr.addr[5]);
        os << dec;
        return os;
    }

private:
    char addr[6];
};

bool find_src_dst(const json& sche, int job_id, int flow_id, int& src_id, int& dst_id) {
    unordered_set<int> sOutflow;
    unordered_set<int> sInflow;
    sOutflow.clear();
    sInflow.clear();
    for (const auto& elem: sche) {
        if (elem["type"] != "link")
            continue;
        int from = elem["from"].get<int>();
        int to = elem["to"].get<int>();

        for (const auto& flow: elem["schedule"]) {
            if (job_id == flow["job_id"].get<int>() &&
                flow_id == flow["flow_id"].get<int>()) {
                sOutflow.insert(from);
                sInflow.insert(to);
            }
        }
    }

    src_id = -1;
    for (int id: sOutflow) {
        if (sInflow.find(id) == sInflow.end()) {
            if (src_id != -1) return false;
            src_id = id;
        }
    }
    
    dst_id = -1;
    for (int id: sInflow) {
        if (sOutflow.find(id) == sOutflow.end()) {
            if (dst_id != -1) return false;
            dst_id = id;
        }
    }

    return src_id != -1 && dst_id != -1;
}

void init_configure() {
	const string my_mac_addr = get_mac_address();
	json topo = *get_topo();
	int my_id = -1;
    std::string my_type;

    MacAddr myMacAddr(my_mac_addr);
	output_src_address = (char*)malloc(6*sizeof(char));
    for (int i = 0; i < 6; i++) output_src_address[i] = myMacAddr.get_addr()[i];

    unordered_map<int, std::string> mId2mac;
    unordered_map<int, std::string> mId2type;
    for (const auto &node: topo["nodes"]) {
        const std::string node_mac = toUpper(node["mac"].get<string>());
        const std::string node_type = node["type"].get<string>();
        const int node_id = node["id"].get<int>();
        mId2mac[node_id] = node_mac;
        mId2type[node_id] = node_type;

        if (node_mac == my_mac_addr) {
            my_id = node_id;
            my_type = node_type;
        }
    }

	if (my_id == -1) {
        std::cout << "[ERROR] Could not find node with mac address " << my_mac_addr << std::endl;
        exit(1);
    }
    
    json sche = *get_schedule();

	// get input & output stream
	for (const auto& elem: sche) {
        if (elem["type"] != "switch")
            continue;
		if (toUpper(elem["mac"].get<string>()) != my_mac_addr)
			continue;

		for (const auto& job: elem["schedule"]) {
			int job_id = job["job_id"].get<int>();
			for (const auto& elem2: sche) {
				if (elem2["type"] != "link")
					continue;
				int from = elem2["from"].get<int>();
        		int to = elem2["to"].get<int>();

				// input stream
				if (to == my_id) {
					for (const auto& flow: elem2["schedule"]) {
						if (flow["job_id"].get<int>() != job_id)
							continue;
						int flow_id = flow["flow_id"].get<int>();
						uint32_t seq_id = (job_id << 8) | flow_id;
						INPUT_STREAM_NUM++;
						input_seq_ids.emplace_back(seq_id);
					}
				}

				// output stream
				if (from == my_id) {
					for (const auto& flow: elem2["schedule"]) {
						if (flow["job_id"].get<int>() != job_id)
							continue;
						int flow_id = flow["flow_id"].get<int>();
						uint32_t seq_id = (job_id << 8) | flow_id;
						OUTPUT_STREAM_NUM++;
						output_seq_ids.emplace_back(seq_id);

						int src_id, dst_id;
						if (!find_src_dst(sche, job_id, flow_id, src_id, dst_id)) {
							cerr << "[Error] Flow#" << flow_id << " in job#" << job_id << " is not valid!" << endl;
							exit(1);
						}

						MacAddr dst_addr(mId2mac[dst_id]);
                        char* dst_addr_array = (char*)malloc(6*sizeof(char));
                        for (int k = 0; k < 6; k++) dst_addr_array[k] = dst_addr.get_addr()[k];
						output_dst_addresses.push_back(dst_addr_array);
					}
				}
			}
		}
	}
    cout << "INPUT_STREAM_NUM = " << INPUT_STREAM_NUM << endl;
    cout << "input_seq_ids = {";
    for (auto& seq_id: input_seq_ids) cout << "0x" << hex << seq_id << dec << ", ";
    cout << "}" << endl;
    cout << "OUTPUT_STREAM_NUM = " << OUTPUT_STREAM_NUM << endl;
    cout << "output_seq_ids = {";
    for (auto& seq_id: output_seq_ids) cout << "0x" << hex << seq_id << dec << ", ";
    cout << "}" << endl;
    cout << "output_dst_addresses = {";
    for (char* c: output_dst_addresses) {
        cout << hex << uppercase;
        for (int i = 0; i < 5; i++) {
            cout << setw(2) << setfill('0') << unsigned(c[i]) << ":";
        }
        cout << setw(2) << setfill('0') << unsigned(c[5]);
        cout << dec;
    }
    cout << "}" << endl;

	// compute time
	for (const auto& elem: sche) {
		if (elem["type"] != "switch")
            continue;
		if (toUpper(elem["mac"].get<string>()) != my_mac_addr)
			continue;
		assert(elem["schedule"].size() == 1);

		const auto& job = elem["schedule"][0];
		uint32_t period = job["period"].get<uint32_t>();
		uint32_t start  = job["start"].get<uint32_t>();
		uint32_t end    = job["end"].get<uint32_t>();

		CYCLE_TIME = (period << 14);
		COMPUTE_OFFSET = (start << 14);
		COMPUTE_TIME = ((end - start - 1) << 14);
	}

    cout << "CYCLE_TIME = " << (CYCLE_TIME >> 14) << endl;
    cout << "COMPUTE_OFFSET = " << (COMPUTE_OFFSET >> 14) << endl;
    cout << "COMPUTE_TIME = " << (COMPUTE_TIME >> 14) + 1 << endl;
}

// int main() {
//     init_configure();
//     return 0;
// }
