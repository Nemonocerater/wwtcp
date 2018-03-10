require 'socket'

module CloudHash
	class Client
		def initialize(host, port)
			@connection = TCPSocket.new(host, port)
		end

		def self.finalize()
			close
			puts "finalize"
		end

		def get(key)
			puts "get #{key}"
			request "GET #{key}"
			puts "get finished..."
		end

		def set(key, value)
			puts "set #{key}"
			request "SET #{key} #{value}"
			puts "set finished..."
		end

		def request(message)
			@connection.puts "#{message}\n"
			@connection.gets
		end

		def close
			request "exit"
			@connection.close
		end
	end
end

loop do
	connection = CloudHash::Client.new('localhost', 4481)
	connection.set 'prez', 'obama'
	connection.get 'prez'
	connection.get 'vp'
	connection.close
	break;
end

