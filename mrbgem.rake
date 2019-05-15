MRuby::Gem::Specification.new('mruby-lspclient') do |spec|
  spec.license = 'MIT'
  spec.authors = 'masahino'

  spec.add_dependency 'mruby-random'
  spec.add_dependency 'mruby-process'
  spec.add_dependency 'mruby-json'
  spec.add_dependency 'mruby-io'
  spec.add_dependency 'mruby-array-ext'
  spec.add_dependency 'mruby-hash-ext'
end
