server_command = "vscode-json-languageserver"
command_options = ['--stdio']
example_file = 'examples/example.json'

client = LSP::Client.new(server_command, {"args" => command_options,
    "initializationOptions" => {"provideFormatter" => "true"}})

# run server and send initialize
id = client.start_server({
    "rootUri"=> "file://" + File.expand_path("..", __FILE__),
    "rootPath"=> File.expand_path("..", __FILE__),
    "capabilities" => {"workspace" => {}},
  })

resp = client.wait_response(id)
puts resp
client.initialized(resp)

# didOpen notification
resp = client.didOpen({"textDocument" => LSP::Parameter::TextDocumentItem.new(example_file)})
puts resp

# completion
resp = client.completion({"textDocument" => LSP::Parameter::TextDocumentIdentifier.new(example_file),
    "position" => {"line" => 4, "character" => 13}}) do |resp|
  puts resp
end

# hover
id = client.hover({"textDocument" => LSP::Parameter::TextDocumentIdentifier.new(example_file),
    "position" => {"line" => 4, "character" => 10}})
resp = client.wait_response(id)
puts "resp of hover"
puts resp

# signatureHelp
id = client.signatureHelp({"textDocument" => LSP::Parameter::TextDocumentIdentifier.new(example_file),
    "position" => {"line" => 12, "character" => 5}})
resp = client.wait_response(id)
puts "resp of signature_help"
puts resp

# definition
id = client.definition({"textDocument" => LSP::Parameter::TextDocumentIdentifier.new(example_file),
    "position" => {"line" => 10, "character" => 4}})
resp = client.wait_response(id)
puts "resp of definition"
puts resp

# references
id = client.references({"textDocument" => LSP::Parameter::TextDocumentIdentifier.new(example_file),
    "position" => {"line" => 0, "character" => 7},
    "context" => {"includeDeclaration" => true}})
resp = client.wait_response(id)
puts "resp of references"
puts resp

# documentSymbol
id = client.documentSymbol({
    "textDocument" => LSP::Parameter::TextDocumentIdentifier.new(example_file)})
resp = client.wait_response(id)
puts "resp of documentSymbol"
puts resp

# formatting
id = client.formatting({"textDocument" => LSP::Parameter::TextDocumentIdentifier.new(example_file),
    "options" => {"tabsize" => 4, "insertSpace" => true}})
resp = client.wait_response(id)
puts "resp of formatting"
puts resp

# rename
id = client.rename({"textDocument" => LSP::Parameter::TextDocumentIdentifier.new(example_file),
    "position" => {"line" => 0, "character" => 7}, "newName" => "GoGoGo"})
resp = client.wait_response(id)
puts "resp of rename"
puts resp

# foldingRange
id = client.foldingRange({"textDocument" => LSP::Parameter::TextDocumentIdentifier.new(example_file)})
resp = client.wait_response(id)
puts "resp of foldingRange"
puts resp

client.shutdown
client.stop_server
puts "recv buffer"
puts client.recv_buffer
puts "request buffer"
puts client.request_buffer
