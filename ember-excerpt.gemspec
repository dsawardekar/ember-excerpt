# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

require 'ember_excerpt/version'

Gem::Specification.new do |spec|
  spec.name          = "ember-excerpt"
  spec.version       = EmberExcerpt::VERSION
  spec.authors       = ["Darshan Sawardekar"]
  spec.email         = ["darshan@sawardekar.org"]
  spec.description   = %q{Extracts keywords from ember documentation.}
  spec.summary       = %q{Extracts keywords like methods, classnames from ember documentation yml.}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
end
