class LSPClientForTextSynchronizationTest < LSP::Client
  attr_reader :notifications

  def initialize
    super('test')
    @notifications = []
  end

  def send_notification(method, params = {})
    @notifications << [method, params]
  end
end

assert('LSP::Client#didChange assigns a version when it is nil') do
  test_path = File.expand_path('../../../examples/example.rb', __FILE__)
  c = LSPClientForTextSynchronizationTest.new
  opened_document = LSP::Parameter::TextDocumentItem.new(test_path, 'ruby', 0)
  c.didOpen({ 'textDocument' => opened_document })
  assert_equal 0, c.file_version[opened_document.uri]
  changed_document = LSP::Parameter::VersionedTextDocumentIdentifier.new(test_path)

  c.didChange({ 'textDocument' => changed_document, 'contentChanges' => [] })

  assert_equal 1, c.file_version[opened_document.uri]
  assert_equal 1, changed_document.version
  assert_equal 'textDocument/didChange', c.notifications[-1][0]
  assert_equal 1, c.notifications[-1][1]['textDocument'].version
end

assert('LSP::Client#didChange preserves an explicit version') do
  test_path = File.expand_path('../../../examples/example.rb', __FILE__)
  c = LSPClientForTextSynchronizationTest.new
  opened_document = LSP::Parameter::TextDocumentItem.new(test_path, 'ruby', 1)
  c.didOpen({ 'textDocument' => opened_document })
  changed_document = LSP::Parameter::VersionedTextDocumentIdentifier.new(test_path, 0)

  c.didChange({ 'textDocument' => changed_document, 'contentChanges' => [] })

  assert_equal 0, changed_document.version
  assert_equal 'textDocument/didChange', c.notifications[-1][0]
  assert_equal 0, c.notifications[-1][1]['textDocument'].version
end
