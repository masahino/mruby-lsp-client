module LSP
  class Client
    def didOpen(params)
      send_notification("textDocument/didOpen", params)
      @file_version[params['textDocument']['uri']] = 1
    end

    def didChange(params)
      if params['textDocument']['version'] == 0
        params['textDocument']['version'] = @file_version[params['textDocument']['uri']]
        @file_version[params['textDocument']['uri']] += 1
      end
      send_notification("textDocument/didChange", params)
    end
  end
end