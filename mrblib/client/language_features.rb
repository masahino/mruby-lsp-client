module LSP
  class Client
    WORKSPACE_FEATURES = [:workspaceSymbol].freeze

    def camel_to_custom_delimiter(camel_case, delimiter)
      camel_case.gsub(/([a-z\d])([A-Z])/, '\1' + delimiter + '\2').downcase
    end

    def method_missing(name, *params, &block)
      request_name = if WORKSPACE_FEATURES.include?(name)
                       camel_to_custom_delimiter(name.to_s, '/')
                     else
                       "textDocument/#{name}"
                     end
      send_request(request_name, *params, &block)
    end

    def respond_to_missing?(sym, include_private)
      features = [
        'completion', 'hover', 'signatureHelp', 'declaration', 'definition', 'typeDefinition',
        'implementation', 'references', 'documentHighlight', 'documentSymbol', 'codeAction',
        'codeLens', 'documentLink', 'documentColor', 'colorPresentation', 'formatting',
        'rangeFormatting', 'onTypeFormatting', 'rename', 'prepareRename', 'foldingRange',
        'selectionRange', 'prepareCallHierarchy', 'linkedEditingRange', 'moniker'
      ]
      # TODO: SemanticTokens
      features.include?(sym) ? true : super
    end
  end
end
