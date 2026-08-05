# frozen_string_literal: true

require 'yaml'
begin
	require 'tty-markdown'
rescue LoadError
end

module EDK
	class Announcement
		VALID_FILENAME_REGEX = /\A\d{4}_\w+\.yml/

		attr_reader :header, :body

		FilenameInvalidError = Class.new(StandardError)

		def self.from_file(filepath)
			yaml = YAML.safe_load(filepath.read)
			
			new(filepath, yaml['header'], yaml['body'])
		end

		def initialize(filepath, header, body)
			@filepath = Pathname.new(filepath)
			raise FilenameInvalidError unless filename_valid?

			@header = header
			@body = body

			read_cache_file_contents!
		end

		def cache_announcement_rendered
			read_cache_file_contents!

			cache_file_contents[announcement_unique_identifier] = true

			update_cached_file
		end

		def render?
			return false if body.empty?

			cache_file_contents[announcement_unique_identifier] != true
		end

		def render
			return unless render?

			display
			cache_announcement_rendered
		end

		private

		attr_reader :filepath
		attr_accessor :cache_file_contents

		def filename_valid?
			filepath.basename.to_s.match?(VALID_FILENAME_REGEX)
		end

		def config
			EDK.config
		end

		def display
			if defined?(TTY::Markdown)
				options = { width: 80, color: EDK::Output.colorize? ? :always : :never }

				EDK::Output.puts TTY::Markdown.parse("**#{header}**", **options)
				EDK::Output.puts TTY::Markdown.parse("***", **options)
				EDK::Output.puts TTY::Markdown.parse(body, **options)

				return
			end

			EDK::Output.info(header)
			EDK::Output.divider
			EDK::Output.puts(body)
		end

		def update_cached_file
			config.__cache_dir.mkpath
			cache_file.open('w') { |f| f.write(cache_file_contents.to_yaml) }
		end

		def announcement_unique_identifier
			@announcement_unique_identifier ||= filepath.basename.to_s[0..3]
		end

		def cache_file
			@cache_file ||= config.__cache_dir.join('.edk-announcements.yml')
		end

		def read_cache_file_contents!
			@cache_file_contents = cache_file.exist? ? YAML.safe_load(cache_file.read) : {}
		end
	end
end

if defined?(TTY::Markdown)
	module EDKMarkdown
		# sempre usar cor azul em vez da conta por conta de problemas de contraste
		# https://gitlab.com/gitlab-org/gitlab-development-kit/-/issues/2301
		def convert_codespan(element, _opts)
			@pastel.blue(element.value)
		end
	end

	TTY::Markdown::Converter.prepend(EDKMarkdown)
end
