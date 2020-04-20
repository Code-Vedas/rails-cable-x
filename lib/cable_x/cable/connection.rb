# frozen_string_literal: true

module CableX
  module Cable
    ##
    # Connection class to serve entry point
    class Connection < ActionCable::Connection::Base
      attr_accessor :device_id
      identified_by :device_id

      def connect
        self.device_id = SecureRandom.hex(20)
      end
    end
  end
end
