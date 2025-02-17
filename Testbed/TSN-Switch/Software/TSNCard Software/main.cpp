#include <arpa/inet.h>
#include <netinet/in.h>
#include <sys/socket.h>

#include <algorithm>
#include <cctype>
#include <condition_variable>
#include <cstdint>
#include <fstream>
#include <iomanip>
#include <iostream>
#include <mutex>
#include <sstream>
#include <thread>
#include <unordered_map>

#include "../Utils/SafeQueue.hpp"
#include "../Utils/json.hpp"
#include "../Utils/message.hpp"
#include "../Utils/utils.hpp"
#include "dma_proxy/buffer_queue.h"
#include "dma_proxy/dma-proxy.h"
#include "md5/md5.h"

using nlohmann::json;
using namespace std;

const string server_ip = "192.168.137.1";

int debug_sockfd;
int ts_sockfd;

bool debug_mode = true;
mutex debug_mutex;

ID mid;  // this switch's ID

// SafeQueue<struct perf_packet> packet_queue;
buffer_queue packet_queue;

void init_socket();
ID get_switch_id(const string& filename = "config.json");
void recv_debug();
void recv_ts();
void send_ts();

int main() {
    // init_socket();
    // cout << "socket init complete" << endl;

    axi_dma_init();
    cout << "DMA init complete" << endl;
    init_queue(&packet_queue);
    // init buffer queue mutex
    if (pthread_mutex_init(&pkt_queue_lock, NULL) != 0) {
        cout << "Fail to initialize buffer queue mutex." << endl;
    }

    // read switch_id
    mid = get_switch_id();
    // one thread for receive debug from server
    // thread recv_debug_thread(recv_debug);
    // one thread for receive ts data from PL
    thread recv_ts_thread(recv_ts);
    // main thread for send ts data to server
    send_ts();
    return 0;
}

void init_socket() {
    // debug socket: receive debug notification from server
    struct sockaddr_in debug_recv_addr;
    if ((debug_sockfd = socket(AF_INET, SOCK_DGRAM, 0)) < 0) {
        perror("debug socket creation failed!");
        exit(EXIT_FAILURE);
    }

    memset(&debug_recv_addr, 0, sizeof(debug_recv_addr));
    debug_recv_addr.sin_family = AF_INET;
    debug_recv_addr.sin_addr.s_addr = INADDR_ANY;
    debug_recv_addr.sin_port = htons(DebugPort);

    if (bind(debug_sockfd, (const struct sockaddr*)&debug_recv_addr,
             sizeof(debug_recv_addr)) < 0) {
        perror("debug socket bind failed!");
        exit(EXIT_FAILURE);
    }

    // timestamp socket: send timestamp data to server
    if ((ts_sockfd = socket(AF_INET, SOCK_DGRAM, 0)) < 0) {
        perror("timestamp socket creation failed");
        exit(EXIT_FAILURE);
    }
}

std::string get_mac_address() {
    ifstream file("/sys/class/net/eth0/address");
    string mac;
    file >> mac;
    return mac;
}

ID get_switch_id(const string& filename) {
    ifstream fin(filename);
    json config = json::parse(fin);
    string mac_addr = get_mac_address();
    std::transform(mac_addr.begin(), mac_addr.end(), mac_addr.begin(),
                   ::toupper);

    ID id = -1;
    string type;

    std::unordered_map<int, std::string> nodes;
    // find current node id, node is either device or switch
    for (auto& node : config["nodes"]) {
        string mac = node["mac"];
        const ID node_id = node["id"].get<ID>();
        string type_info = node["type"];

        std::transform(mac.begin(), mac.end(), mac.begin(), ::toupper);
        if (mac == mac_addr) {
            id = node_id;
            type = type_info;
        }
    }

    if (id == (ID)-1) {
        std::cout << "[ERROR] Could not find node with mac address " << mac_addr
                  << std::endl;
        exit(1);
    }
    std::cout << "[INFO] current node is a " << type << " with id "
              << (unsigned)id << std::endl;

    return id;
}

void recv_debug() {
    // receive debug notification from server
    char msg[100];
    struct sockaddr_in addr;

    memset(&addr, 0, sizeof(addr));
    while (true) {
        int n = ycdfwzy::recv(msg, debug_sockfd, &addr);
        if (n > 0) {
            if (enable_debug_msg.compare(msg) == 0) {
                // write enable debug bit
                lock_guard<mutex> lock(debug_mutex);
                debug_mode = true;
            } else if (disable_debug_msg.compare(msg) == 0) {
                // write disable debug bit
                lock_guard<mutex> lock(debug_mutex);
                debug_mode = false;
            }
        }
    }
}

void recv_ts() {
    // receive timestamps from PL through DMA
    DMA_rx_thread(&packet_queue);
}

void convert_unsigned_string(uint64_t value, string& str, size_t max_len) {
    std::ostringstream oss;
    oss << std::hex << value;

    // Get the string
    str = oss.str();
    while (str.length() > max_len) str.pop_back();
    while (str.length() < max_len) str = "0" + str;

    // If you need a char*, you can get a pointer to the string's buffer
    // const char* cstr = str.c_str();

    // std::cout << "Hex String: " << cstr << '\n';
}

void convert_packet(struct perf_packet& data, char* msg) {
    // cout << "entering convert_packet" << endl;
    string rx_str, tx_str;
    string dst_mac = "";
    string src_mac = "";
    string md5;
    string id_str;
    convert_unsigned_string(data.rx_timestamp, rx_str, 16);
    convert_unsigned_string(data.tx_timestamp, tx_str, 16);
    convert_unsigned_string(mid, id_str, 2);
    string tmp_str;
    for (int i = 0; i < ETHER_ADDR_LEN; i++) {
        convert_unsigned_string(data.ether_dhost[i], tmp_str, 2);
        dst_mac += tmp_str;
    }
    for (int i = 0; i < ETHER_ADDR_LEN; i++) {
        convert_unsigned_string(data.ether_shost[i], tmp_str, 2);
        src_mac += tmp_str;
    }
    // cout << "before md5" << endl;
    md5 = dst_mac + src_mac;
    convert_unsigned_string(data.TPID, tmp_str, 4);
    md5 = md5 + tmp_str;
    convert_unsigned_string(data.vlan_header, tmp_str, 4);
    md5 = md5 + tmp_str;
    convert_unsigned_string(data.ether_type, tmp_str, 4);
    md5 = md5 + tmp_str;
    md5 = MD5(md5).toStr();
    // cout << "after md5" << endl;

    string combined = rx_str + tx_str + dst_mac + src_mac + md5 + id_str;
    cout << "Message: " << combined << endl;
    memcpy(msg, combined.c_str(), combined.length() * sizeof(char));
}

#define MAX_PKT_LEN 1600
uint8_t RxBufferPtr[MAX_PKT_LEN];
bool recv_packet(struct perf_packet* data, buffer_queue* queue, int* len) {
    // cout << "enter recv_packet" << endl;
    bool received = false;
    pthread_mutex_lock(&pkt_queue_lock);
    // printf ("eth_frame.c: Entering critical region for
    // buffer_queue.\r\n");
    if (queue->size > 0) {
        pop_queue(queue, RxBufferPtr, len);
        received = true;
    }
    pthread_mutex_unlock(&pkt_queue_lock);
    if (!received) return false;

    memcpy(data, RxBufferPtr, sizeof(perf_packet));
    data->rx_timestamp = swapByteOrder64(data->rx_timestamp);
    data->tx_timestamp = swapByteOrder64(data->tx_timestamp);

    for (int i = 0; i < 128; i++) {
        // printf("%02x", RxBufferPtr[i]);
        cout << std::setfill('0') << std::setw(2) << std::hex
             << (unsigned)RxBufferPtr[i];
        if ((i + 1) % 4 == 0) cout << " ";
        if ((i + 1) % 32 == 0) cout << endl;
        // if ((i + 1) % 4 == 0) printf(" ");
        // if ((i + 1) % 32 == 0) printf("\n");
    }

    cout << "Rx Timestamp: " << std::setfill('0') << std::setw(16) << std::hex
         << data->rx_timestamp << endl;
    cout << "Tx Timestamp: " << std::setfill('0') << std::setw(16) << std::hex
         << data->tx_timestamp << endl;
    cout << "Dst MAC:      ";
    for (int i = 0; i < ETHER_ADDR_LEN; i++) {
        cout << std::setfill('0') << std::setw(2) << std::hex
             << (unsigned)data->ether_dhost[i];
    }
    cout << endl;
    cout << "Src MAC:      ";
    for (int i = 0; i < ETHER_ADDR_LEN; i++) {
        cout << std::setfill('0') << std::setw(2) << std::hex
             << (unsigned)data->ether_shost[i];
    }
    cout << endl;

    return true;
}

void save_to_file(const char* packed_data, uint8_t* raw_data, int len) {
    string filename = "timestamp.log";
    ofstream fout(filename, std::ios::app);

    for (int i = 0; i < 128; i++) {
        fout << std::setfill('0') << std::setw(2) << std::hex
             << (unsigned)RxBufferPtr[i];
        if ((i + 1) % 4 == 0) fout << " ";
        if ((i + 1) % 32 == 0) fout << endl;
    }

    fout << string(packed_data) << endl;

    fout.close();
}

void send_ts() {
    char* msg = new char[90];
    while (true) {
        struct perf_packet data;
        // packet_queue.pop(data);
        int length;
        if (!recv_packet(&data, &packet_queue, &length)) continue;
        {
            lock_guard<mutex> lock(debug_mutex);
            if (!debug_mode) continue;
        }

        convert_packet(data, msg);

        save_to_file(msg, RxBufferPtr, length);

        // struct sockaddr_in addr;
        // memset(&addr, 0, sizeof(addr));
        // addr.sin_family = AF_INET;
        // addr.sin_addr.s_addr = inet_addr(server_ip.c_str());
        // addr.sin_port = htons(TSPort);

        // // send message to PS
        // ycdfwzy::send(msg, ts_sockfd, &addr);
    }

    delete[] msg;
}