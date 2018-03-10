require 'socket'

#socket = Socket.new(:INET, :STREAM)
#
#remote_addr = Socket.pack_sockaddr_in(4480, '127.0.0.1')
#socket.connect(remote_addr)


#socket = TCPSocket.new('127.0.0.1', 4481)


Socket.tcp('127.0.0.1', 4481) do |connection|
	connection.write "GET / HTTP/1.1\r\n"
	connection.close
end


