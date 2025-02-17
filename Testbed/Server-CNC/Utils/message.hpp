#ifndef MESSAGE_HPP_
#define MESSAGR_HPP_

namespace ycdfwzy {
int recv(char* message, int sockfd, struct sockaddr_in* addr);
void send(const char* message, int sockfd, struct sockaddr_in* addr);
}  // namespace ycdfwzy
#endif