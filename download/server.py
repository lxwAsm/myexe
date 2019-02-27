import socketserver

class MyTcpHandler(socketserver.BaseRequestHandler):
    def handle(self):
        while True:
            try:
                cmd = input(">")
                self.request.send(cmd+';')
                data=self.request.recv(1024)
                print(data)
            except:
                break
        self.request.close()

if __name__ == '__main__':
    server=socketserver.ThreadingTCPServer(('127.0.0.1',1234),MyTcpHandler)
    server.serve_forever()
