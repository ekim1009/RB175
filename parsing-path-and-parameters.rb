require "socket"

def parse_request(request_line)
  http_method, path_and_params, http = request_line.split(" ")
  path, param = path_and_params.split("?")
 
  param = param.split("&").each_with_object({}) do |pair, hash|
    k, v = pair.split("=")
    hash[k] = v
  end
  
  [http_method, path, param]
end

server = TCPServer.new("localhost", 8080)
loop do
  client = server.accept
  
  request_line = client.gets
  puts request_line
  
  http_method, path, param = parse_request(request_line)
 
  client.puts "HTTP/1.1 200 OK"
  client.puts "Content-Type: text/html\r\n\r\n"
  client.puts
  client.puts "<html>"
  client.puts "<body>"
  client.puts "<pre>"
  client.puts http_method
  client.puts path
  client.puts param
  client.puts "</pre>"
  
  client.puts "<h1>Rolls!</h1>"
  rolls = param["rolls"].to_i
  sides = param["sides"].to_i
  
  rolls.times do
    roll = rand(sides) + 1
    client.puts "<p>", roll, "</p>"
  end
  
  client.puts "</body>"
  client.puts "</html>"
  
  client.close
end