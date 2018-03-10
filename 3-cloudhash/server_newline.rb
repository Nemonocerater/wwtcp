require 'socket'

# Supported commands:
# SET key value
# GET key
# exit
module CloudHash
	class Server
		def initialize(port)
			@server = TCPServer.new(port)
			puts "Listening on port #{@server.local_address.ip_port}"
			@storage = {}
		end

		def start()
			Socket.accept_loop(@server) do |connection|
				handle(connection)
				connection.close
				puts "connection ending thanks..."
			end
		end

		def handle(connection)
			loop do
				request = connection.gets
				break if request == "exit" || request == "exit\n"
				if request
					puts request
					connection.puts process(request)
				end
			end
		end

		def process(request)
			command, key, value = request.split
			case command.upcase
			when 'GET'
				@storage[key]

			when 'SET'
				@storage[key] = value
				"Saved: #{key} => #{value}"
			end
		end
	end
end

server = CloudHash::Server.new(4481)
server.start

