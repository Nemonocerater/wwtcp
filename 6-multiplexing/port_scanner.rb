require 'socket'

HOST = ARGV[0] # archive.org
PORT_RANGE = 1..128
TIME_TO_WAIT = 5 # seconds

sockets = PORT_RANGE.map do |port|
	socket = Socket.new(:INET, :STREAM)
	remote_addr = Socket.sockaddr_in(port, HOST)

	begin
		socket.connect_nonblock(remote_addr)
	rescue Errno::EINPROGRESS
	end

	socket
end

loop do
	readable, writable, other = IO.select(nil, sockets, nil, 5)
	break unless writable

	if writable
		writable.each do |socket|
			begin
				socket.connect_nonblock(socket.remote_address)
			rescue Errno::EISCONN
				puts "#{HOST}:#{socket.remote_address.ip_port} accepts connection..."
				sockets.delete(socket)
			rescue Errno::EINVAL
				sockets.delete(socket)
			end
		end
	end
end

