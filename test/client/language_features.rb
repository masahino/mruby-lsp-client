assert('Language Features') do
  assert_false LSP::Client.respond_to?(:completion)
  assert_false LSP::Client.respond_to?(:semanticTokens)
end
