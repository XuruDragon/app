# frozen_string_literal: true

source 'https://rubygems.org'

ruby '2.5.1'

gem 'rails', '5.2.1.1'

gem 'pg', '~> 1.0'

gem 'rufus-scheduler', '~> 3.4.0' # fix for sidekiq-cron not working with rufus 3.5.0
gem 'sidekiq'
gem 'sidekiq-cron'

gem 'haml'
gem 'haml-rails'
gem 'slim-rails'

gem 'ahoy_matey'
gem 'groupdate'

gem 'i18n-js'
gem 'js_cookie_rails'

gem 'inky-rb', require: 'inky'
# Stylesheet inlining for email **
gem 'foundation_emails'
gem 'premailer-rails'

gem 'cancancan'
gem 'devise'
gem 'jwt'
gem 'useragent'

gem 'ransack'

gem 'jbuilder'

gem 'rails-i18n', '~> 5.0' # For 5.0.x and 5.1.x

gem 'dalli'
gem 'turbolinks'

gem 'kaminari'
gem 'url_plumber'

gem 'dynamic_fields_for_rails'

gem 'state_machine'

gem 'bourbon'
gem 'coffee-rails'
gem 'sass-rails'
gem 'webpacker'

gem 'bootstrap-sass'
gem 'font-awesome-sass'

gem 'jquery-rails'
gem 'js-routes'

gem 'uglifier'

gem 'metadown'
gem 'redcarpet'

gem 'puma'
gem 'rack-attack'

gem 'bower-rails'

gem 'highline'
gem 'thor'

gem 'carrierwave'
gem 'mini_magick'

gem 'nokogiri', '>= 1.7.1'
gem 'typhoeus'

gem 'web_translate_it'

gem 'rack-cors', require: 'rack/cors'

gem 'sentry-raven'

gem 'lograge'

gem 'pry-rails'

gem 'bootsnap', '>= 1.1.0', require: false

group :development do
  gem 'i18n-tasks', '~> 0.9.18'
  gem 'listen'
  gem 'rubocop', require: false
  gem 'spring'
  gem 'spring-watcher-listen'
  gem 'web-console'
end

group :test do
  gem 'database_cleaner'
  gem 'faker'
  gem 'minitest-ci'
  gem 'minitest-rails'
  gem 'mocha', require: false
  gem 'rails-perftest'
  gem 'ruby-prof'
  gem 'shoulda', '~> 3.5'
  gem 'shoulda-matchers', '~> 2.0'
  gem 'simplecov', require: false
  gem 'simplecov-console', require: false
  gem 'simplecov-html', require: false
  gem 'timecop'
  gem 'vcr'
  gem 'webmock', require: false
end

group :development, :test do
  gem 'bullet'
  gem 'bundler-audit'
  gem 'byebug', platform: :mri
  gem 'pry-byebug'

  # deployment
  gem 'mina', require: false
  gem 'mina-multistage', require: false
end
