require 'socket'

client = TCPSocket.new('localhost', 4481)
payload = "Lorem Ipsum" * 100_000

#written = client.write_nonblock(payload)
#p written < payload.size
#p written
#p payload.size

p payload.size
begin
	loop do
		bytes = client.write_nonblock(payload)
		p bytes

		break if bytes >= payload.size
		payload.slice!(0, bytes)
		IO.select(nil, [client])
	end

rescue Errno::EAGAIN
	IO.select(nil, [client])
	retry
end

client.close
