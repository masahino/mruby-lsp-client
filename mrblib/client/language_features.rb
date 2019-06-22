module LSP
  class Client
    def completion(params, &block)
      send_request("textDocument/completion", params, &block)
    end
    
    def hover(params, &block)
      send_request("textDocument/hover", params, &block)
    end

    def signatureHelp(params, &block)
      send_request("textDocument/signatureHelp", params, &block)
    end

    def declaration(params, &block)
      send_request("textDocument/declaration", params, &block)
    end

    def definition(params, &block)
      send_request("textDocument/definition", params, &block)
    end
  end
end
