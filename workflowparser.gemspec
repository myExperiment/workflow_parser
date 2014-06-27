# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'workflowparser/version'

Gem::Specification.new do |spec|
  spec.name          = "workflowparser"
  spec.version       = WorkflowParser::VERSION
  spec.authors       = ["Stian Soiland-Reyes"]
  spec.email         = ["support@mygrid.org.uk"]
  spec.summary       = %q{API for parsing various workflow formats}
#  spec.description   = %q{TODO: Write a longer description. Optional.}
  spec.homepage      = "https://github.com/myExperiment/workflow-parser"
  spec.license       = "BSD-3-Clause"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.6"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "coveralls"
  spec.add_development_dependency "minitest", "~> 5.3"
  spec.add_development_dependency "rubocop", "~> 0.24"

  spec.add_runtime_dependency "libxml-ruby", "~> 2.6"

end
