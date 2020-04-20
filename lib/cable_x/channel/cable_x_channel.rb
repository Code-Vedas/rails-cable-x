# frozen_string_literal: true

require_relative '../cable/channel'
require_relative './process/controller'
require_relative './process/request'
require_relative './process/response'
module CableX
  module Channel
    ##
    # CableXChannel class to serve subscription, and cmd execution
    class CableXChannel < Cable::Channel
      include Channel::Process::Controller
      include Channel::Process::Request
      include Channel::Process::Response

      attr_reader :data, :request, :response, :controller_action_hash, :ctrl, :request_id, :response_body

      def subscribed
        reject unless device_id.present?
        stream_from device_id
      end

      def unsubscribed; end

      def cmd(data)
        @data = data
        invoke_controller
        prepare_response
        transmit response_body, via: device_id
      end
    end
  end
end
