# frozen_string_literal: true

require_relative 'lib/tsc/version'

Gem::Specification.new do |spec|
  spec.name          = 'tsc'
  spec.version       = Tsc::VERSION
  spec.authors       = ['Kyle']
  spec.email         = ['bialogs@gmail.com']

  spec.summary       = 'tsc - Twitch Social Credits'
  spec.homepage      = 'http://example.com'
  spec.license       = 'MIT'
  spec.required_ruby_version = '>= 3.0.0'

  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{\A(?:test|spec|features)/}) }
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_dependency 'activerecord'
  spec.add_dependency 'eventmachine'
  spec.add_dependency 'faye-websocket'
  spec.add_dependency 'httparty'
  spec.add_dependency 'sidekiq'
  spec.add_dependency 'sqlite3'

  spec.add_development_dependency 'byebug'
  spec.add_development_dependency 'rubocop'
  spec.add_development_dependency 'rubocop-rails'
  spec.add_development_dependency 'rubocop-rake'
end
