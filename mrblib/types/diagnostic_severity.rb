module LSP
  class DiagnosticSeverity
    extend Type
    CONST = {
      Error: 1,
      Warning: 2,
      Information: 3,
      Hint: 4
    }.freeze
  end
end
