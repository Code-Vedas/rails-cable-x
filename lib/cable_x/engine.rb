# frozen_string_literal: true

require 'active_support'
require 'active_support/rails'
require_relative 'server'
require_relative 'cable/connection'
module CableX
  ##
  # CableX Engine
  class Engine < ::Rails::Engine
    attr_accessor :allowed_request_origins
    isolate_namespace CableX

    def self.server
      config = Rails.application.config_for(:cable_x) rescue nil
      self.allowed_request_origins = config[:allowed_request_origins] if config
      server = CableX::Server.server
      server.config.connection_class = -> { CableX::Cable::Connection }
      server.config.allowed_request_origins = allowed_request_origins
      server
    end
  end
end
