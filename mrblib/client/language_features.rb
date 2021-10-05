module LSP
  class Client
    def method_missing(name, *params, &block)
      send_request("textDocument/#{name}", *params, &block)
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
