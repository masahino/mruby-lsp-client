module LSP
  # module of LSP types
  module Type
    def [](arg)
      self::CONST[arg]
    end

    def key(arg)
      self::CONST.key(arg)
    end
  end
end
