require 'socket'

server = TCPServer.new(4481)

server.setsockopt(Socket::IPPROTO_TCP, Socket::TCP_NODELAY, 1)

