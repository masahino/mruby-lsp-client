module LSP
  # How a completion was triggered
  class CompletionTriggerKind
    extend Type
    CONST = {
      Invoked: 1,
      TriggerCharacter: 2,
      TriggerForIncompleteCompletions: 3
    }.freeze
  end
end
