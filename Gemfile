# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

# Declare your gem's dependencies in cable_x.gemspec.
# Bundler will treat runtime dependencies like base dependencies, and
# development dependencies will be added by default to the :development group.
gemspec

# Declare any dependencies that are still in development here instead of in
# your gemspec. These might include edge Rails or gems from your path or
# Git. Remember to move these dependencies to your gemspec before releasing
# your gem to rubygems.org.

# To use a debugger
# gem 'byebug', group: [:development, :test]
gem 'byebug'
gem 'puma'
gem 'rack-cors'
gem 'redis'
gem 'sqlite3', platform: %i[ruby mswin mingw]
# for JRuby
gem 'activerecord-jdbc-adapter', platform: :jruby
gem 'jdbc-sqlite3', platform: :jruby
