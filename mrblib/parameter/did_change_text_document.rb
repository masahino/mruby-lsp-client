module LSP
  module Parameter
    class DidChangeTextDocumentParams < Base
      def initialize
        @textDocument = nil
        @contentChanges = nil
      end
    end
  end
end