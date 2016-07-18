# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'wordy_number/version'

Gem::Specification.new do |spec|
  spec.name          = "wordy_number"
  spec.version       = WordyNumber::VERSION
  spec.authors       = ["Munish Goyal"]
  spec.email         = ["munishapc@gmail.com"]

  spec.summary       = %q{Dictionary word replacements for a phone number}
  spec.description   = %q{It provides all possible word replacements from a given dictionary (or default dictionary) for a given number.}
  spec.homepage      = 'https://github.com/goyalmunish/wordy_numbers'
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.11"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "rspec-mocks"
  spec.add_development_dependency "byebug"
  spec.add_development_dependency "awesome_print"
end
