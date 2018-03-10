require 'socket'

#server = TCPServer.new(4481)
#
#Socket.accept_loop(server) do |connection|
#	
#	connection.close
#end

Socket.tcp_server_loop(4481) do |connection|
	p connection.fileno
	connection.close
end
