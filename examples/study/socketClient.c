#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <arpa/inet.h>

#define SERVER_IP "127.0.0.1" // 服务器IP
#define SERVER_PORT 8001      // 服务器端口
#define BUFFER_SIZE 1024

int main() {
    int sockfd;
    struct sockaddr_in server_addr;
    char sendbuf[BUFFER_SIZE];
    char recvbuf[BUFFER_SIZE];
    int n;

    // 创建socket
    sockfd = socket(AF_INET, SOCK_STREAM, 0);
    if (sockfd < 0) {
        perror("socket error");
        exit(1);
    }

    // 设置服务器地址
    memset(&server_addr, 0, sizeof(server_addr));
    server_addr.sin_family = AF_INET;
    server_addr.sin_port = htons(SERVER_PORT);
    if (inet_pton(AF_INET, SERVER_IP, &server_addr.sin_addr) <= 0) {
        perror("inet_pton error");
        exit(1);
    }

    // 连接服务器
    if (connect(sockfd, (struct sockaddr*)&server_addr, sizeof(server_addr)) < 0) {
        perror("connect error");
        exit(1);
    }

    printf("Connected to server %s:%d\n", SERVER_IP, SERVER_PORT);

    // 发送和接收数据
    while (fgets(sendbuf, sizeof(sendbuf), stdin) != NULL) {
        write(sockfd, sendbuf, strlen(sendbuf));
        n = read(sockfd, recvbuf, sizeof(recvbuf)-1);
        if (n <= 0) {
            printf("Server closed connection\n");
            break;
        }
        recvbuf[n] = '\0';
        printf("Received: %s", recvbuf);
    }

    close(sockfd);
    return 0;
}
