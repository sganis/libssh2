/* Sample to tests ssh keys
 *
 * The sample code has default values for host name, user and keys
 * but you can specify them on the command line like:
 *
 * "keys host user pub_key sec_key"
 */

#include "libssh2_setup.h"
#include <libssh2.h>

#ifdef HAVE_SYS_SOCKET_H
#include <sys/socket.h>
#endif
#ifdef HAVE_UNISTD_H
#include <unistd.h>
#endif
#ifdef HAVE_NETINET_IN_H
#include <netinet/in.h>
#endif
#ifdef HAVE_ARPA_INET_H
#include <arpa/inet.h>
#endif

#include <stdio.h>
#include <stdlib.h>
#include <string.h>


const char *keyfile1 = "~/.ssh/id_rsa.pub";
const char *keyfile2 = "~/.ssh/id_rsa";
const char *username = "username";
const char *password = "password";


int main(int argc, char *argv[])
{
    uint32_t hostaddr;
    libssh2_socket_t sock;
    int rc;
    struct sockaddr_in sin;
    LIBSSH2_SESSION *session;

#ifdef WIN32
    WSADATA wsadata;
    int err;

    err = WSAStartup(MAKEWORD(2, 0), &wsadata);
    if(err != 0) {
        fprintf(stderr, "WSAStartup failed with error: %d\n", err);
        return 1;
    }
#endif

    if(argc > 1) {
        hostaddr = inet_addr(argv[1]);
    }
    else {
        hostaddr = htonl(0x7F000001);
    }
    if(argc > 2) {
        username = argv[2];
    }
    if(argc > 3) {
        keyfile1 = argv[3]; 
    }
    if(argc > 4) {
        keyfile2 = argv[4]; 
    }

    rc = libssh2_init(0);
    if(rc != 0) {
        fprintf(stderr, "libssh2 initialization failed (%d)\n", rc);
        return 1;
    }

    sock = socket(AF_INET, SOCK_STREAM, 0);
    sin.sin_family = AF_INET;
    sin.sin_port = htons(22);
    sin.sin_addr.s_addr = hostaddr;
    if(connect(sock, (struct sockaddr*)(&sin),
                sizeof(struct sockaddr_in)) != 0) {
        fprintf(stderr, "failed to connect!\n");
        return -1;
    }

    session = libssh2_session_init();
    if(libssh2_session_handshake(session, sock)) {
        fprintf(stderr, "Failure establishing SSH session\n");
        return -1;
    }

    if(libssh2_userauth_publickey_fromfile(session, username, keyfile1, keyfile2, NULL)) {
        fprintf(stderr, "libssh2 FAILED\n");
        goto shutdown;
    }
    else {
        fprintf(stderr, "libssh2 PASSED\n");
    }

  shutdown:
    libssh2_session_disconnect(session, "Normal Shutdown");
    libssh2_session_free(session);

#ifdef WIN32
    closesocket(sock);
#else
    close(sock);
#endif
    libssh2_exit();
    return 0;
}
