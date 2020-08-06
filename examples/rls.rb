server_command = "rls"

client = LSP::Client.new(server_command)
rootUri = ENV['HOME'] + "/projects/example/"
# run server and send initialize
id = client.start_server({
    "rootUri"=> "file://" + rootUri,
    "capabilities" => {},
  })

puts client.wait_response(id)
client.initialized

# didOpen notification
resp = client.didOpen({"textDocument" => LSP::Parameter::TextDocumentItem.new(rootUri + 'src/main.rs')})
puts resp

# definition
id = client.definition({"textDocument" => LSP::Parameter::TextDocumentIdentifier.new(rootUri + 'src/main.rs'),
    "position" => {"line" => 26, "character" => 40}})
resp = client.wait_response(id)
puts "resp of definition"
puts resp

# completion
resp = client.completion({"textDocument" => LSP::Parameter::TextDocumentIdentifier.new(rootUri + 'src/main.rs'),
    "position" => {"line" => 36, "character" => 20}}) do |resp|
  puts "resp of completion"
  puts resp.to_json
end
puts resp

client.shutdown
client.stop_server
puts "recv buffer"
puts client.recv_buffer
puts "request buffer"
puts client.request_buffer
