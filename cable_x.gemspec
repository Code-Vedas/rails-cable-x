# frozen_string_literal: true

$LOAD_PATH.push File.expand_path('lib', __dir__)

# Maintain your gem's version:
require 'cable_x/version'
Gem::Specification.new do |spec|
  spec.name = 'cable_x'
  spec.version = CableX::VERSION
  spec.authors = ['Nitesh Purohit']
  spec.email = ['nitesh.purohit.it@gmail.com']
  spec.summary = 'Standard MVC over cable for realtime applications to enjoy seamless experience over cable'
  spec.description = 'Standard MVC over cable for realtime applications to enjoy seamless experience over cable. Use specialized clients for Android, IOS, Angular, React, JS'
  spec.homepage = 'https://github.com/Code-Vedas/rails-cable-x'
  spec.license = 'MIT'

  spec.files = Dir['{app,config,db,lib}/**/*', 'MIT-LICENSE', 'Rakefile', 'README.md']

  spec.add_dependency 'rails', '>= 5.1'
  spec.metadata['homepage_uri'] = spec.homepage
  spec.metadata['source_code_uri'] = 'https://github.com/Code-Vedas/rails-cable-x'
  spec.metadata['changelog_uri'] = 'https://github.com/Code-Vedas/rails-cable-x'
  spec.required_ruby_version = Gem::Requirement.new('>= 2.3.0')
  spec.required_rubygems_version = '>= 1.8.11'
end
