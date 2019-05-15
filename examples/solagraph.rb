server_command = "solargraph"
command_options = ['stdio']

client = LSP::Client.new(server_command, command_options)

# run server and send initialize
id = client.start_server({"rootUri"=> "file://" + File.expand_path("..", __FILE__)})

puts client.wait_response(id)
client.initialized

# didOpen notification
resp = client.didOpen({"textDocument" => LSP::Parameter::TextDocumentItem.new('examples/example.rb')})
puts resp

# definition
id = client.definition({"textDocument" => LSP::Parameter::TextDocumentIdentifier.new('examples/example.rb'),
    "position" => {"line" => 3, "character" => 4}})
resp = client.wait_response(id)
puts "resp of definition"
puts resp

# completion
resp = client.completion({"textDocument" => LSP::Parameter::TextDocumentIdentifier.new('examples/example.rb'),
    "position" => {"line" => 5, "character" => 6}}) do |resp|
  puts resp
end
puts resp

client.shutdown
client.stop_server
puts "recv buffer"
puts client.recv_buffer
puts "request buffer"
puts client.request_buffer