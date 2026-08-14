module LSP
  class Client
    def didOpen(params)
      send_notification('textDocument/didOpen', params)
      @file_version[params['textDocument'].uri] = params['textDocument'].version
    end

    def didChange(params)
      if params['textDocument'].version.nil?
        @file_version[params['textDocument'].uri] += 1
        params['textDocument'].version = @file_version[params['textDocument'].uri]
      end
      send_notification('textDocument/didChange', params)
    end

    def didSave(params)
      send_notification('textDocument/didSave', params)
    end

    def didClose(params)
      send_notification('textDocument/didClose', params)
      @file_version.delete(params['textDocument'].uri)
    end
  end
end
