module LSP
  module Parameter
    class Base
      def to_h
        instance_variables.map do |k|
          v = instance_variable_get(k)
          if v.kind_of? Base
            [k.to_s[1..-1], v.to_h]
          else
            [k.to_s[1..-1], v]
          end
        end.to_h.delete_if{|k, v| v == nil}
      end

      def to_json
        to_h.to_json
      end

      def to_s
        to_h
      end
    end
  end
end