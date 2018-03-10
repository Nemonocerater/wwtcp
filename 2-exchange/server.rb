require 'socket'
one_kb = 1024
one_hundred_kb = 1024 * 100

Socket.tcp_server_loop(4481) do |connection|
	connection.write "Welcome!"

	#puts connection.read
	
	#while data = connection.read(one_kb) do
	#	print data
	#end
	
	begin
		while data = connection.readpartial(one_hundred_kb) do
			p data
		end
	rescue EOFError
		p "Done Reading!"
	end

	connection.close
end
