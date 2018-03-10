require 'socket'

module CloudHash
	class Server
		def initialize(port)
			@SIZE_OF_INT = [1].pack('i').size # probably 4, at least on my Mac (shrug)
			@server = TCPServer.new(port)
			puts "Listening on port #{@server.local_address.ip_port}"
			@storage = {}
		end

		def start()
			Socket.accept_loop(@server) do |connection|
				handle(connection)
				connection.close
			end
		end

		def handle(connection)
			packed_msg_length = connection.read(@SIZE_OF_INT)
			p packed_msg_length
			p packed_msg_length.unpack('i')
			msg_length = packed_msg_length.unpack('i').first
			p msg_length

			request = connection.read(msg_length)
			puts request
			connection.write process(request)
		end

		# Supported commands:
		# SET key value
		# GET key
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

