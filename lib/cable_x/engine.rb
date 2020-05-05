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
      setup_rate_limiting
      server = CableX::Server.server
      server.config.connection_class = -> { CableX::Cable::Connection }
      server.config.allowed_request_origins = allowed_request_origins
      server
    end

    def self.setup_rate_limiting
      cable_config = Rails.application.config_for(:cable) rescue nil
      config = Rails.application.config_for(:cable_x) rescue nil
      return unless config && cable_config

      self.allowed_request_origins = config[:allowed_request_origins]
      CableX::Cable::Connection.redis_config = cable_config
      CableX::Cable::Connection.rate_limit = config[:rate_limit] if cable_config[:adapter] == 'redis'
    end
  end
end
