# frozen_string_literal: true

EDK.component do
	feature_category :design_system

	legacy_service 'webpack'

	config do
		settings :webpack do
			bool(:enabled) { true }
			string(:host) { config.encore.rails.hostname }
			port(:port, 'webpack')
			string(:public_address) { "" }
			bool(:static) { false }
			bool(:vendor_dll) { false }
			bool(:incremental) { true }
			integer(:incremental_ttl) { 30 }
			bool(:sourcemaps) { true }
			bool(:live_reload) { true }
			array(:allowed_hosts) { config.encore.rails.allowed_hosts }
			integer(:vue_version) { 2 }

			bool(:__set_vue_version) do
				config.webpack.vue_version == 3
			end

			string(:__dev_server_public) do
				if !config.webpack:live_reload
					""
				elsif !config.webpack.public_address.empty?
					config.webpack.public_address
				elsif config.nginx?
					# webpack por trás de nginx
					if config.https?
						"wss://#{config.nginx.__listen_address}/_hmr/"
					else
						"ws://#{config.nginx.__listen_address}/_hmr/"
					end
				else
					""
				end
			end
		end
	end

	smoke_test 'iniciar webpack' do |config:|
		config.bury!('vite.enabled', false)
		config.bury!('webpack.enabled', true)
		config.save_yaml!

		raise 'falha ao iniciar o webpack' unless EDK::Shellout.new(%w[edk start encore-http-router webpack]).execute.success?

		retry_until_true do
			GDK::Shellout.new(%W[curl --fail #{config.hostname}:#{config.webpack.port}]).execute.success?
		end
	end
end
