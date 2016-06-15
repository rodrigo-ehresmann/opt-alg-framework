# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'opt_alg_framework/version'

Gem::Specification.new do |spec|
  spec.name          = "opt_alg_framework"
  spec.version       = OptAlgFramework::VERSION
  spec.authors       = ["rodrigo-ehresmann"]
  spec.email         = ["igoehresmann@gmail.com"]

  spec.summary       = %q{Gem with a optimization algorithm framework that implements problems, algorithms and operator classes.}
  spec.homepage      = "https://github.com/rodrigo-ehresmann/opt_alg_framework"
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = 'https://rubygems.org'
  end

  spec.add_development_dependency "bundler", "~> 1.9"
  spec.add_development_dependency "rake", "~> 10.0"
end
