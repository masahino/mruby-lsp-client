assert('LSP::Parameter::TextDocumentContentChangeEvent 1') do
  e = LSP::Parameter::TextDocumentContentChangeEvent.new("hoge")
  eh = e.to_h
  assert_equal "hoge", eh['text']
  assert_equal nil, eh['range']
  assert_equal nil, eh['rangeLength']
end

assert('LSP::Parameter::TextDocumentContentChangeEvent 2') do
  e = LSP::Parameter::TextDocumentContentChangeEvent.new("abcdefghijklmn\n", 
    LSP::Parameter::Range.new(0, 0, 1, 3), 10)
  eh = e.to_h
  assert_equal "abcdefghijklmn\n", eh['text']
  assert_equal 0, eh['range']['start']['line']
  assert_equal 0, eh['range']['start']['character']
  assert_equal 1, eh['range']['end']['line']
  assert_equal 3, eh['range']['end']['character']
  assert_equal 10, eh['rangeLength']
end

