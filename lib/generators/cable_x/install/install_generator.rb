# frozen_string_literal: true

module CableX
  ##
  # Install generator
  class InstallGenerator < Rails::Generators::Base
    source_root File.expand_path('templates', __dir__)

    def create_install_file
      route('mount CableX::Engine.server => "/cable_x"')
      template 'cable_x_yml.rb.tt', File.join('config', 'cable_x.yml')
    end
  end
end
