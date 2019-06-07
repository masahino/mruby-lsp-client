server_command = "clangd"

client = LSP::Client.new(server_command)

# run server and send initialize
id = client.start_server({"rootUri"=> "file://" + File.expand_path("..", __FILE__)})
resp = client.wait_response(id)

client.initialized

# didOpen notification
client.didOpen({"textDocument" => LSP::Parameter::TextDocumentItem.new('examples/example.c')})

# definition
id = client.definition({"textDocument" => LSP::Parameter::TextDocumentIdentifier.new('examples/example.c'),
    "position" => {"line" => 21, "character" => 9}})
resp = client.wait_response(id)
puts resp

# completion
id = client.completion({"textDocument" => LSP::Parameter::TextDocumentIdentifier.new('examples/example.c'),
    "position" => {"line" => 0, "character" => 1}})
resp = client.wait_response(id)
puts resp

client.shutdown

client.stop_server
puts "========== recv_buffer =========="
puts client.recv_buffer
puts "========== request_buffer =========="
puts client.request_buffer

