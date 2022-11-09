# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.1.2'
gem 'bootsnap', '>= 1.4.4', require: false
gem 'jbuilder', '~> 2.7'
gem 'pg', '~> 1.1'
gem 'puma', '~> 5.0'
gem 'rails', '~> 6.1.6', '>= 6.1.6.1'
gem 'sass-rails', '>= 6'
# gem 'turbolinks', '~> 5'
gem 'webpacker', '~> 5.0'

# not default
gem 'activerecord-import'
gem 'graphql'
gem 'graphql-client'
gem 'meta-tags'
gem 'net-imap'
gem 'net-pop'
gem 'net-smtp'
gem 'react-rails'
gem 'slim-rails'
gem 'whenever', require: false

group :development, :test do
  gem 'byebug', platforms: %i[mri mingw x64_mingw]

  # not default
  gem 'dead_end'
  gem 'factory_bot_rails'
  gem 'pry-byebug'
  gem 'spring-commands-rspec'
  gem 'traceroute'
end

group :development do
  gem 'listen', '~> 3.3'
  gem 'rack-mini-profiler', '~> 2.0'
  gem 'rubocop', require: false
  gem 'rubocop-fjord', require: false
  gem 'slim_lint'
  gem 'spring'
  gem 'web-console', '>= 4.1.0'
end

group :test do
  gem 'capybara', '>= 3.26'
  gem 'selenium-webdriver', '>= 4.0.0.rc1'
  gem 'webdrivers'

  # not default
  gem 'rspec-rails', '~> 6.0.0'
end

gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]
