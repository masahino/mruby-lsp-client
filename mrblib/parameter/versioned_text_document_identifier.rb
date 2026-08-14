module LSP
  module Parameter
    # An identifier to denote a specific version of a text document.
    # This information usually flows from the client to the server.
    class VersionedTextDocumentIdentifier < TextDocumentIdentifier
      attr_accessor :version

      def initialize(file_path, version = nil)
        super(file_path)
        @version = version
      end
    end
  end
end
