module LSP
  class Client
    def completion(params)
      send_request("textDocument/completion", params)
    end
    
    def definition(params)
      send_request("textDocument/definition", params)
    end
  end
end
