MRuby::Gem::Specification.new('mruby-lsp-client') do |spec|
  spec.license = 'MIT'
  spec.authors = 'masahino'

  spec.add_dependency 'mruby-random'
  spec.add_dependency 'mruby-process'
  spec.add_dependency 'mruby-json'
  spec.add_dependency 'mruby-io'
  spec.add_dependency 'mruby-array-ext'
  spec.add_dependency 'mruby-hash-ext'
  spec.add_dependency 'mruby-env'
  spec.add_dependency 'mruby-errno'
end
