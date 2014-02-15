# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'affilinet/version'

Gem::Specification.new do |spec|
  spec.name          = "affilinet"
  spec.version       = Affilinet::VERSION
  spec.authors       = ["Eduardo Sampaio"]
  spec.email         = ["eduardo@sampa.io"]
  spec.description   = %q{Gem to access the rest (actually only get but...) API of affilinet}
  spec.summary       = %q{Gem to access the rest (actually only get but...) API of affilinet}
  spec.homepage      = "http://github.com/esampaio/affilinet"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "faraday", "~> 0.8.0"
  spec.add_dependency "faraday_middleware", "~> 0.8.0"
  spec.add_dependency "hashie"

  spec.add_development_dependency "bundler", "~> 1.5"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "vcr"
  spec.add_development_dependency "webmock"
  spec.add_development_dependency "simplecov"
end
