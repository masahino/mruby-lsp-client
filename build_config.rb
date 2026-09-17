MRuby::Build.new do |conf|
  toolchain :gcc
  conf.gembox 'default'
  conf.gem File.expand_path(File.dirname(__FILE__))
  conf.gem mgem: 'mruby-json' do |g|
    g.test_rbfiles = []
    g.test_objs = []
    g.skip_test = true
  end
  conf.enable_test
end
