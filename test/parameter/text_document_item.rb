assert('LSP::Paramter::TextDocumentItem') do
  test_path = File.expand_path("../../../examples/test.rb", __FILE__)
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
  assert_equal nil, td.guess_lang('/foo/bar/hoge.xxx')
end
