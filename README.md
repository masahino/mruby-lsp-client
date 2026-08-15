# mruby-lsp-client   [![Build Status](https://travis-ci.org/masahino/mruby-lsp-client.svg?branch=master)](https://travis-ci.org/masahino/mruby-lsp-client)

## install by mrbgems
- add conf.gem line to `build_config.rb`

```ruby
MRuby::Build.new do |conf|

    # ... (snip) ...

    conf.gem :github => 'masahino/mruby-lsp-client'
end
```

## Starting an LSP server

Use the LSP initialization sequence to start a server:

```ruby
initialize_id = client.start_server(initialize_params)
initialize_response = client.wait_response(initialize_id)
client.initialized(initialize_response)
```

`start_server` starts the server process, sends an initialize request, and
changes the client status to `:initializing`. After receiving the initialize
response, call `initialized` to update the server capabilities, send the
initialized notification, and change the client status to `:running`.

The client starts the command passed to `LSP::Client` and communicates with the
server through its standard input and output.

## Supported operations

### Text document synchronization

- `didOpen`
- `didChange`
- `didSave`
- `didClose`

### Language feature requests

- `completion`
- `hover`
- `signatureHelp`
- `declaration`
- `definition`
- `typeDefinition`
- `implementation`
- `references`
- `documentHighlight`
- `documentSymbol`
- `codeAction`
- `codeLens`
- `documentLink`
- `documentColor`
- `colorPresentation`
- `formatting`
- `rangeFormatting`
- `onTypeFormatting`
- `rename`
- `prepareRename`
- `foldingRange`
- `selectionRange`
- `prepareCallHierarchy`
- `linkedEditingRange`
- `moniker`
- `workspaceSymbol`

### Request cancellation

Use `cancel_request_with_method` to send `$/cancelRequest` for pending requests
with the specified method.

## Shutting down an LSP server

Use the LSP shutdown sequence to terminate a server normally:

```ruby
shutdown_id = client.shutdown
client.wait_response(shutdown_id)
client.exit
```

`shutdown` sends a shutdown request but does not stop the client. After receiving
the shutdown response, call `exit` to send the exit notification and change the
client status to `:stop`.

The LSP server is expected to terminate itself after receiving the exit
notification. Do not use `Process.kill` as part of the normal shutdown sequence.

## License
under the MIT License:
- see LICENSE file
