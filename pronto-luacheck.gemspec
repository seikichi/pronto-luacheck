# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'pronto/luacheck/version'

Gem::Specification.new do |spec|
  spec.name          = 'pronto-luacheck'
  spec.version       = Pronto::Luacheck::VERSION
  spec.authors       = ['Seiichi KONDO']
  spec.email         = ['seikichi@kmc.gr.jp']

  spec.summary       = 'Pronto runner for Luacheck'
  spec.description   = <<-EOF
    A pronto runner for Luacheck - Lua code analyzer.
    Pronto runs analysis quickly by checking only the relevant changes.
    Created to be used on pull requests, but suited for other scenarios as well.
  EOF
  spec.homepage      = 'https://github.com/seikichi/pronto-luacheck'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.11'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'minitest', '~> 5.0'
  spec.add_development_dependency 'rubocop', '~> 0.40'
end
