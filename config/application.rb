require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module PartiHome
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.2

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.

    config.time_zone = 'Asia/Seoul'
    config.i18n.available_locales = [:en, :ko]
    config.i18n.default_locale = :ko
    config.exceptions_app = self.routes
    config.action_view.field_error_proc = Proc.new { |t, i| t }

    I18n.backend.class.send(:include, I18n::Backend::Cascade)
  end
end
