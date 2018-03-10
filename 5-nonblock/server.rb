require 'socket'

Socket.tcp_server_loop(4481) do |connection|
	loop do
		begin
			puts connection.read_nonblock(4096)
		rescue Errno::EAGAIN
			print '.'
			IO.select([connection])
			retry
		rescue EOFError
			break
		end
	end

	connection.close
end

# Nonblocking Accept

#server = TCPServer.new(4481)
#
#loop do
#	begin
#		connection = server.accept_nonblock
#	rescue Errno::EAGAIN
#		# do other important work
#		retry
#	end
#end


# Nonblocking Connect

#socket = Socket.new(:INET, :STREAM)
#remote_addr = Socket.pack_sockaddr_in(80, 'www.google.com')
#
#begin
#	socket.connect_nonblock(remote_addr)
#rescue Errno::EINPROGRESS
#	# operation is already in progress
#rescue Errno::EALREADY
#	# a previous non blocking connection is already in progress
#rescue Errno::ECONNREFUSED
#	# the remote host refused to connect
#end
