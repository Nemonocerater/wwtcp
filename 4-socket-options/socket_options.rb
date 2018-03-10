require 'socket'

socket = TCPSocket.new('google.com', 80)
# Get an instance of Socket::Option representing the type of socket.
opt = socket.getsockopt(Socket::SOL_SOCKET, Socket::SO_TYPE)
#opt = socket.getsockopt(:SOCKET, :TYPE)

opt.int == Socket::SOCK_STREAM
opt.int == Socket::SOCK_DGRAM

