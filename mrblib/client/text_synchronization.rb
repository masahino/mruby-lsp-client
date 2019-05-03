module LSP
  class Client
    def didOpen(params)
      send_notification("textDocument/didOpen", params)
    end

  end
end