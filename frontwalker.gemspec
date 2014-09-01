# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'frontwalker/version'

Gem::Specification.new do |spec|
  spec.name          = "frontwalker"
  spec.version       = Frontwalker::VERSION
  spec.authors       = ["Kazuyuki Honda"]
  spec.email         = ["hakobera@gmail.com"]
  spec.summary       = "Frontwalker is a tool to manage CloudFront. It defines the state of CloudFront distibutions using own DSL, and updates CloudFront according to the DSL."
  spec.description   = "Frontwalker is a tool to manage CloudFront."
  spec.homepage      = "https://github.com/hakobera/frontwalker"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "aws-sdk", ">= 1.52.0", "< 2.0.0"
  spec.add_dependency "term-ansicolor"
  spec.add_dependency "uuid"
  spec.add_dependency "systemu"
  spec.add_development_dependency "bundler", "~> 1.6"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec", "~> 3.0"
end
