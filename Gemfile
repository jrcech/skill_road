# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.7.2'

gem 'jbuilder', '~> 2.11', '>= 2.11.2'
gem 'pg', '~> 1.2', '>= 1.2.3'
gem 'puma', '~> 5.2', '>= 5.2.1'
gem 'rails', '~> 6.1', '>= 6.1.1'
gem 'webpacker', '~> 5.2', '>= 5.2.1'

gem 'bootsnap', '~> 1.7', '>= 1.7.2', require: false

group :development, :test do
  gem 'byebug', platforms: %i[mri mingw x64_mingw]
end

group :development do
  gem 'listen', '~> 3.4', '>= 3.4.1'
  gem 'web-console', '~> 4.1'
end

gem 'devise', github: 'heartcombo/devise', branch: 'ca-omniauth-2'
gem 'email_validator'
gem 'gretel'
gem 'mailgun-ruby'
gem 'omniauth'
gem 'omniauth-facebook'
gem 'omniauth-google-oauth2'
gem 'omniauth-rails_csrf_protection'
gem 'pagy'
gem 'rolify'
gem 'simple_form'
gem 'slim-rails'

group :development do
  gem 'brakeman'
  gem 'bundler-audit'
  gem 'fasterer'
  gem 'flay'
  gem 'overcommit'
  gem 'rails_best_practices'
  gem 'reek'
  gem 'rubocop', require: false
  gem 'rubocop-rspec', require: false
  gem 'rubycritic', require: false
  gem 'slim_lint'
end

group :development do
  gem 'better_errors'
  gem 'binding_of_caller'
  gem 'letter_opener'
  # gem 'meta_request'
  gem 'pry-awesome_print'
  gem 'pry-rails'
end

group :development, :test do
  gem 'amazing_print'
  gem 'bullet'
  gem 'factory_bot_rails'
  gem 'faker'
  gem 'pry-byebug'
  gem 'rspec-rails'
end

group :test do
  gem 'capybara'
  gem 'selenium-webdriver'
  gem 'shoulda-matchers'
  gem 'simplecov', require: false
  gem 'vcr'
  gem 'w3c_validators'
  gem 'webdrivers', '~> 4.0', require: false
  gem 'webmock'
end

group :development do
  gem 'annotate'
  gem 'rails-erd'
  gem 'seedbank'
end
