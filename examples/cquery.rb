server_command = "cquery"

client = LSP::Client.new(server_command,
  {"initializationOptions" => {"cacheDirectory" => "/tmp/cquery/cache"}})

# run server and send initialize
id = client.start_server({"rootUri" => "file://" + File.expand_path("..", __FILE__)})
resp = client.wait_response(id)
puts resp

client.initialized(resp)
sleep(10)

# didOpen notification
client.didOpen({"textDocument" => LSP::Parameter::TextDocumentItem.new('examples/example.c')})

# completion
id = client.completion({"textDocument" => LSP::Parameter::TextDocumentIdentifier.new('examples/example.c'),
    "position" => {"line" => 15, "character" => 3}})
resp = client.wait_response(id)
puts "completion"
puts resp

# signatureHelp
id = client.signatureHelp({"textDocument" => LSP::Parameter::TextDocumentIdentifier.new('examples/example.c'),
    "position" => {"line" => 4, "character" => 8}})
resp = client.wait_response(id)
puts "signatureHelp"
puts resp

# hover
id = client.hover({"textDocument" => LSP::Parameter::TextDocumentIdentifier.new('examples/example.c'),
    "position" => {"line" => 20, "character" => 8}})
resp = client.wait_response(id)
puts "hover"
puts resp

# definition
id = client.definition({"textDocument" => LSP::Parameter::TextDocumentIdentifier.new('examples/example.c'),
    "position" => {"line" => 11, "character" => 20}})
if id != nil
  resp = client.wait_response(id)
  puts "definition"
  puts resp
end

client.shutdown

client.stop_server
puts "========== recv_buffer =========="
puts client.recv_buffer
puts "========== request_buffer =========="
puts client.request_buffer

