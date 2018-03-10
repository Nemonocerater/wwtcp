require 'socket'


# Create socket bound to port 4481
socket = Socket.new(:INET, :STREAM)
addr = Socket.pack_sockaddr_in(4481, '0.0.0.0')
socket.bind(addr)

# Open socket to listen for incoming connections
max_conn = Socket::SOMAXCONN
print "Max Connections: "
p max_conn
socket.listen(max_conn)

# Accept a connection
loop do
	connection, _ = socket.accept

	# Print out data
	print "Connection class: "
	p connection.class

	print "Server fileno: "
	p socket.fileno

	print "Connection fileno: "
	p connection.fileno

	print "Local address: "
	p connection.local_address

	print "Remote address: "
	p connection.remote_address

	# Close connection
	connection.close
end

# Close the connection to the server
# This will probably never be hit
# socket.close_write
# socket.close_read
socket.close

