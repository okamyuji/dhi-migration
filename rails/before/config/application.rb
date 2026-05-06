require_relative "boot"

require "rails"
require "action_controller/railtie"

module DhiSample
  class Application < Rails::Application
    config.load_defaults 8.0
    config.api_only = true
    config.eager_load = true
    config.consider_all_requests_local = false
    config.hosts.clear
    config.logger = Logger.new($stdout)
    config.secret_key_base = ENV.fetch("SECRET_KEY_BASE") { "a" * 64 }
  end
end
