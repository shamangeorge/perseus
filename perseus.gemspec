# frozen_string_literal: true

lib = File.expand_path('./lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'perseus/version'

Gem::Specification.new do |spec|
  spec.name          = 'perseus'
  spec.version       = Perseus::VERSION
  spec.authors       = ['shamangeorge']
  spec.email         = ['shamangeorge@fruitopology.net']

  spec.summary       = 'ruby http wrapper to query open resources from perseus@tufts.edu.'
  spec.description   = 'This gem provides a ruby cli http wrapper around the perseus CTS API and its xmlmorph apis'
  spec.homepage      = 'https://github.com/shamangeorge/perseus'
  spec.license       = 'MIT'

  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{\A(?:test|spec|features)/}) }
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']
  spec.required_ruby_version = '>= 3.0'

  spec.add_development_dependency 'bundler', '~> 2.0'
  spec.add_development_dependency 'rake', '~> 13.0'
  spec.add_development_dependency 'rspec', '~> 3.0'
  spec.add_dependency 'activesupport'
  spec.add_dependency 'awesome_print'
  spec.add_dependency 'hashie'
  spec.add_dependency 'ox'
  spec.add_dependency 'rexml'
  spec.add_dependency 'pry', '~>0.10'
  spec.add_dependency 'roman-numerals'
end
