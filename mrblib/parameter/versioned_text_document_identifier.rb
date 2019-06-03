module LSP
  module Parameter
    class VersionedTextDocumentIdentifier < TextDocumentIdentifier
      attr_accessor :version
      def initialize(file_path, version)
        super(file_path)
        @version = version
      end
    end
  end
end