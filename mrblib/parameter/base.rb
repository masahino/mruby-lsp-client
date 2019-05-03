module LSP
  module Parameter
    class Base
      def to_h
        instance_variables.map do |k|
          [k.to_s[1..-1], instance_variable_get(k)]
        end.to_h
      end

      def to_json
$stdeer.puts "to_json"
        to_h.to_json
      end

      def to_s
        to_h
      end
    end
  end
end