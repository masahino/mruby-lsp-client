module LSP
  class Client
    def completion(params, &block)
      send_request("textDocument/completion", params, &block)
    end
    
    def definition(params, &block)
      send_request("textDocument/definition", params, &block)
    end
  end
end
