assert('LSP::ErrorCodes') do
  # ParseError: -32700,
  assert_equal -32700, LSP::ErrorCodes[:ParseError]
  # InvalidRequest: -32600,
  assert_equal :InvalidRequest, LSP::ErrorCodes.key(-32600)
end

assert('LSP::CompletionTriggerKind') do
  assert_equal 1, LSP::CompletionTriggerKind[:Invoked]
  assert_equal :TriggerCharacter, LSP::CompletionTriggerKind.key(2)
end

assert('LSP::CompletionItemKind') do
  assert_equal nil, LSP::CompletionItemKind[:unknwon]
  assert_equal 7, LSP::CompletionItemKind[:Class]
  assert_equal nil, LSP::CompletionItemKind.key(99)
  assert_equal :Module, LSP::CompletionItemKind.key(9)
end

assert('LSP::DiagnosticSeverity') do
  assert_equal 1, LSP::DiagnosticSeverity[:Error]
  assert_equal :Information, LSP::DiagnosticSeverity.key(3)
end

assert('LSP::TextDocumentSyncKind') do
  assert_equal 1, LSP::TextDocumentSyncKind[:Full]
  assert_equal :Incremental, LSP::TextDocumentSyncKind.key(2)
end
