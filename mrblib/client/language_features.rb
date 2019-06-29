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

    def typeDefinition(params, &block)
      send_request("textDocument/typeDefinition", params, &block)
    end

    def implementation(params, &block)
      send_request("textDocument/implementation", params, &block)
    end

    def references(params, &block)
      send_request("textDocument/references", params, &block)
    end

    def documentSymbol(params, &block)
      send_request("textDocument/documentSymbol", params, &block)
    end

    def formatting(params, &block)
      send_request("textDocument/formatting", params, &block)
    end

    def rangeFormatting(params, &block)
      send_request("textDocument/rangeFormatting", params, &block)
    end

    def rename(params, &block)
      send_request("textDocument/rename", params, &block)
    end

    def foldingRange(params, &block)
      send_request("textDocument/foldingRange", params, &block)
    end
  end
end
