# coding: utf-8

lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "mathml2asciimath/version"

Gem::Specification.new do |spec|
  spec.name          = "mathml2asciimath"
  spec.version       = MathML2AsciiMath::VERSION
  spec.authors       = ["Ribose Inc."]
  spec.email         = ["open.source@ribose.com"]

  spec.summary       = "Convert MathML to AsciiMath "
  spec.description   = <<~DESCRIPTION
    Convert MathML to AsciiMath

    This gem is in active development.
  DESCRIPTION

  spec.homepage      = "https://github.com/riboseinc/mathml2asciimath"
  spec.license       = "BSD-2-Clause"

  spec.bindir        = "bin"
  spec.require_paths = ["lib"]
  spec.files         = `git ls-files`.split("\n")
  spec.test_files    = `git ls-files -- {spec}/*`.split("\n")
  spec.required_ruby_version = Gem::Requirement.new(">= 2.3.0")

  spec.add_dependency "htmlentities", "~> 4.3.4"
  spec.add_dependency "nokogiri"

  spec.add_development_dependency "bundler", "~> 2.0.1"
  spec.add_development_dependency "byebug", "~> 9.1"
  spec.add_development_dependency "rspec-match_fuzzy", "~> 0.1.3"
  spec.add_development_dependency "guard", "~> 2.14"
  spec.add_development_dependency "guard-rspec", "~> 4.7"
  spec.add_development_dependency "rake", "~> 12.0"
  spec.add_development_dependency "rspec", "~> 3.6"
  spec.add_development_dependency "rubocop", "= 0.54.0"
  spec.add_development_dependency "simplecov", "~> 0.15"
  spec.add_development_dependency "timecop", "~> 0.9"
end
