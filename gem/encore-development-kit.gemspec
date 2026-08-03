# frozen_string_literal: true

$LOAD_PATH.unshift(File.expand_path('lib', __dir__))

require 'encore_development_kit'

Gem::Specification.new do |spec|
	spec.name        = 'encore-development-kit'
	spec.version     = EDK::GEM_VERSION
	spec.authors     = ['cavassani', 'encore']
	spec.email       = ['encore_rubygems@encore.com']

	spec.summary     = 'cli para kit de desenvolvimento de encore.'
	spec.description = 'cli para kit de desenvolvimento de encore.'
	spec.homepage    = 'https://github.com/keepchasingheaven/encore-development-kit'
	spec.license     = 'MIT'
	spec.files       = ['lib/encore_development_kit.rb']
	spec.executables = ['edk']

	spec.required_ruby_version = '>= 3.2.0'
	spec.metadata['rubygems_mfa_required'] = 'true'

	spec.add_dependency 'encore-sdk', '~> 0.3.1'
  	spec.add_dependency 'rake', '~> 13.1'
  	spec.add_dependency 'sentry-ruby', '~> 5.23'
  	spec.add_dependency 'terminal-table', '~> 3.0.2'
  	spec.add_dependency 'tty-markdown', '~> 0.7.2'
  	spec.add_dependency 'tty-spinner', '~> 0.9.3'
  	spec.add_dependency 'zeitwerk', '~> 2.6.15'
end
