require_relative 'boot'

require 'rails/all'
require "action_cable"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module HrApp
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.
    config.middleware.use "PDFKit::Middleware", :print_media_type => true
    config.session_store :cookie_store
	  config.middleware.use ActionDispatch::Cookies
	  config.middleware.use ActionDispatch::Session::CookieStore, config.session_options
	  config.middleware.use Rack::MethodOverride
  end
end
