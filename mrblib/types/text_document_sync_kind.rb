module LSP
  class TextDocumentSyncKind
    extend Type
    CONST = {
      None: 0,
      Full: 1,
      Incremental: 2
    }.freeze
  end
end
