# frozen_string_literal: true

lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'ftc_event/version'

Gem::Specification.new do |spec|
  spec.name          = 'ftc_event'
  spec.version       = FtcEvent::VERSION
  spec.authors       = ['Jeremy Cole']
  spec.email         = ['jeremy@jcole.us']

  spec.summary       = 'A library for accessing a FIRST Tech Challenge scorekeeper event database.'
  spec.description   = spec.summary
  spec.homepage      = 'http://github.com/jeremycole/ftc_event'
  spec.license       = 'MIT'

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 2.0'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 3.0'
  spec.add_development_dependency 'rubocop'

  spec.add_dependency 'sqlite3'
end
