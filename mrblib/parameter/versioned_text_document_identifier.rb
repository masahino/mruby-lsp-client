module LSP
  module Parameter
    class VersionedTextDocumentIdentifier < TextDocumentIdentifier
      def initialize(file_path, version)
        super(file_path)
        @version = version
      end
    end
  end
end