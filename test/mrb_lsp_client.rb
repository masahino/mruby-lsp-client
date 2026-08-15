assert('LSP::Client') do
  c = LSP::Client.new('hoge')
  assert_equal :stop, c.status
  tmpdir = ENV['TMPDIR'] || ENV['TMP'] || ENV['TEMP'] || ENV['USERPROFILE'] || '/tmp'
  assert_equal "#{tmpdir}/mruby_lsp_hoge_#{$$}.log", c.logfile
  _id = c.start_server({})
  assert_equal :initializing, c.status
end

class LSPClientForCancelRequestTest < LSP::Client
  attr_reader :notifications

  def initialize
    super('test')
    @notifications = []
  end

  def send_notification(method, params = {})
    @notifications << [method, params]
  end
end

class LSPClientForShutdownTest < LSP::Client
  attr_reader :requests, :notifications

  def initialize
    super('test')
    @requests = []
    @notifications = []
  end

  def send_request(method, params = {})
    @requests << [method, params]
  end

  def send_notification(method, params = {})
    @notifications << [method, params]
  end
end

assert('LSP::Client#cancel_request_with_method') do
  c = LSPClientForCancelRequestTest.new
  c.request_buffer[1] = { message: { 'method' => 'textDocument/completion' } }
  c.request_buffer[2] = { message: { 'method' => 'textDocument/hover' } }

  c.cancel_request_with_method('textDocument/completion')

  assert_equal [['$/cancelRequest', { 'id' => 1 }]], c.notifications
  assert_equal false, c.request_buffer.key?(1)
  assert_equal true, c.request_buffer.key?(2)
end

assert('LSP::Client#shutdown sends a request without stopping') do
  c = LSPClientForShutdownTest.new
  c.status = :running

  c.shutdown

  assert_equal [['shutdown', {}]], c.requests
  assert_equal :running, c.status
end

assert('LSP::Client#exit sends a notification and stops') do
  c = LSPClientForShutdownTest.new
  c.status = :running

  c.exit

  assert_equal [['exit', {}]], c.notifications
  assert_equal :stop, c.status
end

assert('LSP::Client#stop_server is removed') do
  c = LSPClientForShutdownTest.new

  assert_equal false, c.respond_to?(:stop_server)
end

assert('initialize') do
  c = LSP::Client.new('ruby', { 'args' => ["#{File.dirname(__FILE__)}/../misc/dummy_lsp.rb"] })

  id = c.start_server({})
  resp = c.wait_response(id)
  assert_kind_of Hash, resp
  c.shutdown
end

assert('no Content-Length') do
  c = LSP::Client.new('ruby', { 'args' => ["#{File.dirname(__FILE__)}/../misc/dummy_lsp.rb"] })

  id = c.start_server({ 'response' => { 'header' => "Content-Type:application/vscode-jsonrpc; charset=utf-8\r\n\r\n",
                                        'message' => '0123456789' } })
  resp = c.wait_response(id)
  assert_equal nil, resp
  c.shutdown
end

#assert('unmatch Content-Length') do
#  c = LSP::Client.new('ruby', { 'args' => ["#{File.dirname(__FILE__)}/../misc/dummy_lsp.rb"] })
#
#  id = c.start_server({ 'response' => { 'header' => "Content-Length:10\r\n\r\n",
#                                        'message' => { 'data' => 'abcde' } } })
#  resp = c.wait_response(id)
#  assert_kind_of Hash, resp
#  c.shutdown
#end
