server_command = 'yaml-language-server'

client = LSP::Client.new(server_command, {"args" => ['--stdio']})
puts 'start'

# run server and send initialize
id = client.start_server({ 'rootUri' => "file://" + File.expand_path('..', __FILE__) })
resp = client.wait_response(id)
puts resp
client.initialized(resp)

# didOpen notification
client.didOpen({ 'textDocument' => LSP::Parameter::TextDocumentItem.new('examples/example.yml') })

# definition
id = client.definition({"textDocument" => LSP::Parameter::TextDocumentIdentifier.new('examples/example.yml'),
    "position" => {"line" => 21, "character" => 9}})
resp = client.wait_response(id)
puts resp

# completion
id = client.completion({"textDocument" => LSP::Parameter::TextDocumentIdentifier.new('examples/example.yml'),
    "position" => {"line" => 0, "character" => 1}})
resp = client.wait_response(id)
puts resp

# completion
id = client.codeLens({"textDocument" => LSP::Parameter::TextDocumentIdentifier.new('examples/example.yml')})
resp = client.wait_response(id)
puts resp

client.shutdown

client.stop_server
puts "========== recv_buffer =========="
puts client.recv_buffer
puts "========== request_buffer =========="
puts client.request_buffer

