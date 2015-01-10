# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'rspec_error_summary/version'

Gem::Specification.new do |spec|
  spec.name          = "rspec_error_summary"
  spec.version       = RspecErrorSummary::VERSION
  spec.authors       = ["Jose Santiago"]
  spec.email         = ["contact@josesantiagojr.com"]
  spec.summary       = %q{Summarize RSpec error output}
  spec.description   = %q{Parses RSpec error output to provide a summary showing what errors were encountered, the number of occurrences per error, and file path and line number locations}
  spec.homepage      = "http://github.com/binarydev/rspec_error_summary"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = ["rspec_error_summary"]
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 10.0"

  spec.add_dependency 'colorize', '~> 0.7.5'
end
