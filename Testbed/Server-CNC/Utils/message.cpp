#include <netinet/in.h>
#include <sys/socket.h>
#include <unistd.h>

#include <cstring>
#include <iostream>

namespace ycdfwzy {

#define MAX_PKT_LEN 1600

int recv(char* message, int sockfd, struct sockaddr_in* addr) {
    int len, n;
    len = sizeof(*addr);

    n = recvfrom(sockfd, (char*)message, MAX_PKT_LEN, MSG_WAITALL,
                 (struct sockaddr*)addr, (socklen_t*)&len);
    message[n] = '\0';
    return n;
}

int send(const char* message, int sockfd, struct sockaddr_in* addr) {
    // memset(servaddr, 0, sizeof(*servaddr));

    // servaddr->sin_family = AF_INET;
    // servaddr->sin_port = htons(8080);
    // servaddr->sin_addr.s_addr = INADDR_ANY;

    return sendto(sockfd, (const char*)message, strlen(message), 0,
                  (const struct sockaddr*)addr, sizeof(*addr));
}

}  // namespace ycdfwzy
