# frozen_string_literal: true

require 'action_cable'
require 'rails'
require_relative 'cable_x/engine'
require_relative 'cable_x/server'
require_relative 'cable_x/version'
require_relative 'cable_x/channel/cable_x_channel'
module CableX
  class Error < StandardError; end
end
