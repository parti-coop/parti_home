source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

gem 'bundler', '2.0.1'

#ruby '2.3.1'

gem 'unicorn'
gem 'puma', '~> 3.12'
gem 'rails', '~> 5.2.3'
gem 'mini_racer'
gem 'new_google_recaptcha'
gem 'active_interaction', '~> 3.7'

# database
gem 'sqlite3'
gem 'mysql2', '~> 0.5.2'

# view
gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0'
gem 'jquery-rails', '~> 4.3', '>= 4.3.5'
gem 'haml-rails', '~> 2.0', '>= 2.0.1'
gem 'bootstrap', '~> 4.3', '>= 4.3.1'
gem 'sprockets-rails', '~> 3.2', '>= 3.2.1'
gem 'redcarpet'
gem 'htmlentities'
gem 'browser'
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'mini_racer', platforms: :ruby
# gem 'coffee-rails', '~> 4.2'
gem 'turbolinks', '~> 5'
gem 'webpacker', '~> 4.x'
# gem 'jbuilder', '~> 2.5'

# gem 'redis', '~> 4.0'
# Use ActiveModel has_secure_password
gem 'bcrypt', '~> 3.1.7'
gem 'kaminari'

gem 'httparty'
gem 'dotenv-rails'
gem 'slack-notifier'

# Use ActiveStorage variant
# gem 'mini_magick', '~> 4.8'

# gem 'capistrano-rails', group: :development

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '>= 1.1.0', require: false

# file
gem 'carrierwave'
gem 'mini_magick'
gem 'file_validators'
gem 'fog'

# admin
gem 'devise'
gem 'devise-bootstrap-views'
gem 'activeadmin', '~> 2.6'
gem 'activeadmin_easymde', git: 'https://github.com/parti-coop/activeadmin_easymde'
# gem 'activeadmin_easymde', path: '/Users/dalikim/workspace/activeadmin_easymde'

# deploy
gem 'travis'

# seo
gem 'meta-tags', '~> 2.1'
gem 'sitemap_generator'

group :development, :test do
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
end

gem 'spring'
gem 'spring-watcher-listen', '~> 2.0.0'

group :development do
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '>= 3.0.5', '< 3.2'
end

group :test do
  gem 'capybara', '>= 2.15'
  gem 'selenium-webdriver'
  gem 'chromedriver-helper'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
