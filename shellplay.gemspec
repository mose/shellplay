# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

Gem::Specification.new do |spec|
  spec.name          = "shellplay"
  spec.version       = File.read(File.expand_path('../CHANGELOG.md', __FILE__))[/([0-9]+\.[0-9]+\.[0-9]+)/]
  spec.authors       = ["mose"]
  spec.email         = ["mose@mose.com"]
  spec.summary       = %q{CLI tool for shell-based presentations.}
  spec.description   = %q{CLI tool for shell-based presentation. Think powerpoint in the console for commandline demos.}
  spec.homepage      = "https://github.com/mose/shellplay"
  spec.metadata      = { "changelog" => "https://github.com/mose/shellplay/blob/master/CHANGELOG.md" }
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^spec/})
  spec.require_paths = ["lib"]

  spec.add_dependency 'paint'
  spec.add_dependency 'cliprompt'
  spec.add_dependency 'configstruct'

  spec.add_development_dependency "bundler", "~> 1.6"
  spec.add_development_dependency "rake"
  spec.add_development_dependency 'rspec'
  spec.add_development_dependency 'coveralls'
end
