module LSP
  class Client
    def didOpen(params)
      send_notification("textDocument/didOpen", params)
    end

    def didChange(params)
      send_notification("textDocument/didChange", params)
    end
  end
end