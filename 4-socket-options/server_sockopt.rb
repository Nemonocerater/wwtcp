require 'socket'

# Create a server that can take back over the port if it needs to do a quick restart
server = TCPServer.new('localhost', 4481)
server.setsockopt(:SOCKET, :REUSEADDR, true)

server.getsockopt(:SOCKET, :REUSEADDR)

