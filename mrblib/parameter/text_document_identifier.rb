module LSP
  module Parameter
    class TextDocumentIdentifier < Base
      attr_accessor :uri
      def initialize(file_path)
        @uri = 'file://' + File::expand_path(file_path)
      end
    end
  end
end
