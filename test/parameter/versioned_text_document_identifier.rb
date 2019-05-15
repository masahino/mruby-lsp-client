assert('LSP::Paramter::VersionedTextDocumentIdentifier') do
  test_path = File.expand_path("../../../examples/example.rb", __FILE__)
  td = LSP::Parameter::VersionedTextDocumentIdentifier.new(test_path, 1)
  tmp = td.to_h
  assert_equal "file://" + test_path, tmp['uri']
  assert_equal 1, tmp['version']
end