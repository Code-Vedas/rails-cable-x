# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }
gemspec

gem 'puma', '>= 5.3.1'
gem 'rack-cors'
gem 'redis'
gem 'coveralls', '~> 0.8.23'
gem 'rspec-rails', '~> 4.0.2'
gem 'sqlite3', platform: %i[ruby mswin mingw]
# for JRuby
gem 'activerecord-jdbc-adapter', platform: :jruby
gem 'jdbc-sqlite3', platform: :jruby
gem 'rubocop'