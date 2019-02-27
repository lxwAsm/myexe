import socket
if "__main__" == __name__:
    try:
        sock = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
        sock.bind(('localhost', 1234))
        sock.listen(5)
    except:
        print "init socket err!"
    while True:
        print "listen for client..."
        client, addr = sock.accept()
        print "get client connection"
        print addr
        while True:
            cmd = raw_input('$>')
            if cmd[:9]=="downlocal":
                name = input("localname:")
                client.send(cmd)
                f = open(name,'w+')
                total_data=[]
                while True:
                    data = client.recv(1024)    
                    if not data: break
                    total_data.append(data)
                f.write(''.join(total_data))
                f.close()
            elif cmd[:6]=="upload":
                pass
            elif cmd=="exit":
                break
            else:
                client.send(cmd)
                szBuf = client.recv(1024)
                print(szBuf)
        conn.close()
            