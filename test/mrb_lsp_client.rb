assert("LSP::Client") do
  c = LSP::Client.new("hoge")
  assert_equal :stop, c.status
  assert_equal "/tmp/mruby_lsp_hoge.log", c.logfile
  id = c.start_server({})
  assert_equal :initializing, c.status
end