# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'appdirect/version'

Gem::Specification.new do |spec|
  spec.name          = "appdirect"
  spec.version       = AppDirect::VERSION
  spec.authors       = ["Tim Williams"]
  spec.email         = ["tim@teachmatic.com"]
  spec.summary       = %q{Ruby wrapper for AppDirect API}
  spec.description   = %q{Basic ruby wrapper for the AppDirect Vendor API. Handles event retrieval and parsing XML in to Ruby object.}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.6"
  spec.add_development_dependency "minitest", "~> 5.4"
  spec.add_development_dependency "vcr", '~> 2.9'
  spec.add_development_dependency "webmock",'~> 1.20'
  spec.add_development_dependency "rake"

  spec.add_dependency 'oauth', '~> 0.4'
  spec.add_dependency 'nori', '~> 1.1.0'
end
