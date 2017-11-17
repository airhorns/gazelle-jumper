# frozen_string_literal: true

source "https://rubygems.org"

git_source(:github) {|repo_name| "https://github.com/#{repo_name}" }

gem 'httparty'
gem 'json'
gem 'recursive-open-struct'
gem 'ejson'
gem 'byebug'
gem 'lastfm'
gem 'sequel'
gem 'sqlite3'
gem 'rake'

gem 'whenever', :require => false

group :development do
  gem 'capistrano', '~> 3.10'
  gem 'capistrano-rbenv'
  gem 'capistrano-bundler'
  gem 'capistrano-rails'
  gem 'capistrano-ejson', github: 'Shopify/capistrano-ejson', ref: '544f3cc0d636586e4b789a4a489f120af765030f'
end
