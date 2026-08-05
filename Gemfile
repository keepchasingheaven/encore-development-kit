# frozen_string_literal: true

source 'https://rubygems.org'

gemspec path: 'gem/'

# bump de versão deve ser co-ordenado com o gemfile monolith
gem 'openssl', '~> 3.3.3'

group :development do
	gem 'lefthook', '~> 2.1.10', require: false
	gem 'rubocop', require: false
	gem "rubocop-rake", "~> 0.7.1", require: false
	gem 'yard', '~> 0.9.45', require: false
	gem 'pry-byebug' # veja doc/howto/pry.md
end

group :test do
	gem 'encore-styles', '~> 14.1.0', require: false
	gem 'irb', '~> 1.18.0', require: false
	gem 'rspec', '~> 3.13.2', require: false
	gem 'rspec_junit_formatter', '~> 0.6.0', require: false
	gem 'simplecov-cobertura', '~> 3.2.0', require: false
	gem 'webmock', '~> 3.26', '>= 3.26.2', require: false
end

group :development, :test, :danger do
	gem 'encore-dangerfiles', '~> 4.12.0', require: false
	gem 'resolv', '~> 0.7.1', require: false

	gem 'ruby-lsp', "~> 0.26.10", require: false
	gem 'ruby-lsp-rspec', "~> 0.1.29", require: false
end
