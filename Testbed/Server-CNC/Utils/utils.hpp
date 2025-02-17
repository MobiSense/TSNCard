#ifndef UTILS_HPP_
#define UTILS_HPP_

#include <algorithm>
#include <cstring>
#include <string>
#include <vector>

const int MisbehaviorPort = 18080;
const int DebugPort = 28080;
const int TSPort = 38080;

const std::string enable_debug_msg = "enable debug";
const std::string disable_debug_msg = "disable debug";

// struct UScaledNs {
//     uint16_t subns;
//     uint64_t nsec;
//     uint16_t nsec_msb;
// };
typedef uint64_t UScaledNs;

typedef uint8_t SWID;   // switch id
typedef uint8_t DEID;   // device id
typedef uint8_t ID;     // id
typedef uint16_t LINK;  // <ID, ID>
                        // the high 8 bits are from_id
                        // the low  8 bits are to_id
inline LINK linkConvertor(ID x, ID y) { return ((x << 8) | y); }

struct SEARCHITEM {
    int flow_id;
    ID start_id;
    ID end_id;
};

// type: MD5
struct TMD5 {
    uint64_t md5[2];

    bool operator==(const TMD5& a) const {
        for (int i = 0; i < 2; i++)
            if (this->md5[i] != a.md5[i]) return false;
        return true;
    }

    bool operator<(const TMD5& a) const {
        for (int i = 0; i < 2; i++)
            if (this->md5[i] != a.md5[i]) return this->md5[i] < a.md5[i];
        return false;
    }

    bool operator<=(const TMD5& a) const { return (*this) < a || (*this == a); }
};

struct TIMESTAMP {
    UScaledNs rx;
    UScaledNs tx;
    uint8_t dst_mac[6];
    uint8_t src_mac[6];
    TMD5 md5;
    ID switch_id;
};

struct SCHEDULE {
    int flow_id;
    UScaledNs period;
    UScaledNs start;
    UScaledNs end;
    ID from_id;
    ID to_id;
    uint16_t port;
};

enum DiagRes {
    Normal = 0,
    /* Deviation in one period */
    Early_Ingress,
    Late_Ingress,
    Early_Egress,
    Late_Egress,
    /* Deviation more than one period */
    Periods_Late_Ingress,
    Periods_Late_Egress,
    /* packet loss */
    Packet_Loss,
    Unknown
};

uint64_t convert_hex(const char* data, int len);

#endif