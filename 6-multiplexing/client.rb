require 'socket'

if ARGV.length > 0
	port = ARGV[0]
else
	puts "no port specified"
	exit
end

remote_addr = Socket.pack_sockaddr_in(port, '127.0.0.1')
socket = Socket.new(:INET, :STREAM)

# Connect to the host
begin
	socket.connect_nonblock(remote_addr)
rescue Errno::EINPROGRESS
	puts "Connection in progress"
	IO.select(nil, [socket])

	begin
		socket.connect_nonblock(remote_addr)
	rescue Errno::ECONNREFUSED
		puts "connection refused 1"
		exit
	rescue Errno::EISCONN
		socket.write "Hey, what's up"
	end
rescue Errno::ECONNREFUSED
	puts "connection refused 2"
rescue Errno::EISCONN
	socket.write "Hey, what's up"
end

socket.close
