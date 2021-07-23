assert("LSP::Client") do
  c = LSP::Client.new("hoge")
  assert_equal :stop, c.status
  tmpdir = ENV['TMPDIR'] || ENV['TMP'] || ENV['TEMP'] || ENV['USERPROFILE'] || "/tmp"
  assert_equal tmpdir + "/mruby_lsp_hoge_" + $$.to_s + ".log", c.logfile
  id = c.start_server({})
  assert_equal :initializing, c.status
end
