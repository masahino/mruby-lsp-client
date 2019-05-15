module LSP
  module Parameter
    class TextDocumentContentChangeEvent < Base
      def initialize(text, range = nil, range_length = nil)
        @range = range
        @rangeLength = range_length
        @text = text
      end
    end
  end
end