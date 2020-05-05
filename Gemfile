# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }
gemspec

gem 'puma'
gem 'rack-cors'
gem 'redis'
gem 'sqlite3', platform: %i[ruby mswin mingw]
# for JRuby
gem 'activerecord-jdbc-adapter', platform: :jruby
gem 'jdbc-sqlite3', platform: :jruby
