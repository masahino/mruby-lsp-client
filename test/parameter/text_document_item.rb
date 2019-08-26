assert('LSP::Paramter::TextDocumentItem') do
  test_path = File.expand_path("../../../examples/example.rb", __FILE__)
  td = LSP::Parameter::TextDocumentItem.new(test_path)
  tmp = td.to_h
  assert_equal "file://" + test_path, tmp['uri']
  assert_equal "ruby", tmp['languageId']
  assert_equal 1, tmp['version']

  test_path = File.expand_path("../../../examples/example.py", __FILE__)
  td = LSP::Parameter::TextDocumentItem.new(test_path)
  tmp = td.to_h
  assert_equal "file://" + test_path, tmp['uri']
  assert_equal "python", tmp['languageId']
  assert_equal 1, tmp['version']

end

assert('LSP::Paramter::TextDocumentItem non exist file') do
  test_path = File.expand_path("../../../examples/file_not_found.rb", __FILE__)
  td = LSP::Parameter::TextDocumentItem.new(test_path)
  tmp = td.to_h
  assert_equal "file://" + test_path, tmp['uri']
  assert_equal "ruby", tmp['languageId']
  assert_equal 1, tmp['version']
end

assert('LSP::Parameter::TextDocumentItem.guess_lang') do
  td = LSP::Parameter::TextDocumentItem.new(__FILE__)
  assert_equal 'dockerfile', td.guess_lang('Dockerfile')
  assert_equal 'dockerfile', td.guess_lang('/foo/bar/Dockerfile')
  assert_equal 'makefile', td.guess_lang('Makefile')
  assert_equal 'bat', td.guess_lang('/foo/bar/hoge.bat')
  assert_equal 'yaml', td.guess_lang('/foo/bar/hoge.yaml')
  assert_equal 'go', td.guess_lang('/foo/bar/hoge.go')
  assert_equal nil, td.guess_lang('/foo/bar/hoge.xxx')
end
