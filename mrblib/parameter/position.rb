module LSP
  module Parameter
    class Position < Base
      def initialize(line, character)
        @line = line
        @character = character
      end
    end
  end
end