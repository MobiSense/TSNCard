#include "utils.hpp"


uint64_t convert_hex(const char* data, int len) {
    char str[100];
    memcpy(str, data, sizeof(char) * len);
    str[len] = '\0';
    // std::cout << data << std::endl;

    return std::strtoull(str, nullptr, 16);
}