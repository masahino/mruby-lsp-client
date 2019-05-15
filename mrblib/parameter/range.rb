module LSP
  module Parameter
    class Range < Base
      def initialize(start_line, start_char, end_line, end_char)
        @start = LSP::Parameter::Position.new(start_line, start_char)
        @end = LSP::Parameter::Position.new(end_line, end_char)
      end

      def to_h
        {
          "start" => @start.to_h,
          "end" => @end.to_h
        }
      end
    end
  end
end
