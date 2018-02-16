# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'perseus/version'

Gem::Specification.new do |spec|
  spec.name          = "perseus"
  spec.version       = Perseus::VERSION
  spec.authors       = ["shamangeorge"]
  spec.email         = ["shamangeorge@fruitopology.net"]

  spec.summary       = %q{ruby http wrapper to query open resources from perseus@tufts.edu.}
  spec.description   = %q{This gem provides a ruby cli http wrapper around the perseus CTS API and its xmlmorph apis}
  spec.homepage      = "https://github.com/gem/perseus"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features|examples)/}) || File.basename(f).start_with?(".")
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.14"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_dependency "pry"
  spec.add_dependency "ox"
  spec.add_dependency "awesome_print"
  spec.add_dependency "roman-numerals"
  spec.add_dependency "activesupport"
  spec.add_dependency "hashie"
  spec.add_dependency "elasticsearch"
end
