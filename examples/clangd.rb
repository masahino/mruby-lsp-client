server_command = "clangd"
command_options = []

client = LSP::Client.new(server_command, command_options)

# run server and send initialize
id = client.start_server({"rootUri"=> "file://" + File.expand_path("..", __FILE__) + "mruby"})
resp = client.wait_response(id)

client.initialized

# didOpen notification
client.didOpen({"textDocument" => LSP::Parameter::TextDocumentItem.new('mruby/src/array.c')})

# definition
id = client.definition({"textDocument" => LSP::Parameter::TextDocumentIdentifier.new('mruby/src/array.c'),
    "position" => {"line" => 21, "character" => 9}})
resp = client.wait_response(id)
puts resp

# completion
id = client.completion({"textDocument" => LSP::Parameter::TextDocumentIdentifier.new('mruby/src/array.c'),
    "position" => {"line" => 21, "character" => 9}})
resp = client.wait_response(id)
puts resp

client.shutdown

client.stop_server
puts "========== recv_buffer =========="
puts client.recv_buffer
puts "========== request_buffer =========="
puts client.request_buffer
