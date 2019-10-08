# Load the Rails application.
require_relative 'application'

# Initialize the Rails application.
Rails.application.initialize!

PartiHome::Application.default_url_options = PartiHome::Application.config.action_mailer.default_url_options