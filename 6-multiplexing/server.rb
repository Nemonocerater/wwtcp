require 'socket'

def socket_puts(socket, message)
	print "[" + socket.local_address.ip_port.to_s + ":" + socket.remote_address.ip_port.to_s + "] "
	puts message
end

port = 4481
pool = []

for i in 0..2
	pool.push(TCPServer.new(port + i))
end

#connections = [<TCPSocket>, <TCPSocket>, <TCPSocket>]
connections = []

loop do
	puts "\twaiting for IO.select..."
	ready = IO.select(pool + connections)

	ready[0].each do |socket|
		if pool.include? socket
			begin
				accepted_socket = socket.accept_nonblock
				connections.push(accepted_socket)
				socket_puts(accepted_socket, "Socket opened")
			rescue Errno::EAGAIN
			end
		elsif connections.include? socket
			begin
				data = socket.read_nonblock(4069)
				socket_puts(socket, data)
			rescue Errno::EAGAIN
			rescue EOFError
				connections.delete(socket)
				socket_puts(socket, "Closing socket...")
				socket.close
				puts "Socket closed"
			end
		else
			puts "Unknown connection..."
			p socket
		end
	end

end
