# frozen_string_literal: true

module CableX
  ##
  # CableX ActionCable server module
  module Server
    extend ActionCable

    def self.server
      @server ||= ActionCable::Server::Base.new
    end
  end
end
