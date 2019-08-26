server_command = "gopls"

client = LSP::Client.new(server_command, {"args" => ["-v"]})

# run server and send initialize
#rootUri = ENV['HOME'] + "/go/src/github.com/sourcegraph/go-langserver/"
rootUri = ENV['HOME'] + "/go/src/example/"
id = client.start_server({"rootUri"=> "file://" + rootUri})

puts client.wait_response(id)
client.initialized

# didOpen notification
resp = client.didOpen({"textDocument" => LSP::Parameter::TextDocumentItem.new(rootUri + 'main.go')})
puts resp

# definition
id = client.definition({"textDocument" => LSP::Parameter::TextDocumentIdentifier.new(rootUri + 'main.go'),
    "position" => {"line" => 5, "character" => 0}})
resp = client.wait_response(id)
puts "resp of definition"
puts resp

# completion
resp = client.completion({
    "textDocument" => LSP::Parameter::TextDocumentIdentifier.new(rootUri + 'main.go'),
    "position" => {"line" => 8, "character" => 1},
  }) do |resp|
  puts resp.to_json
end
puts resp

client.shutdown
client.stop_server
puts "recv buffer"
puts client.recv_buffer
puts "request buffer"
puts client.request_buffer
