# frozen_string_literal: true

require_relative './rate_limit/block_check'
require_relative './rate_limit/rate_limit'
require_relative './rate_limit/rate_limit_redis'

module CableX
  module Cable
    ##
    # Connection class to serve entry point
    class Connection < ActionCable::Connection::Base
      include RateLimit::RateLimitRedis
      include RateLimit::CheckRateLimit
      include RateLimit::BlockCheck

      class << self
        attr_accessor :rate_limit, :redis_config
      end

      attr_accessor :device_id, :rate_limit, :redis_config, :redis
      identified_by :device_id

      def connect
        self.device_id = Digest::SHA1.hexdigest(request_str)
        setup_rate_limit
      rescue StandardError => _e
        reject_unauthorized_connection
      end

      def receive(message)
        if (blocked_unit = check_block) || (blocked_unit = do_rate_limit)
          disconnect_client(blocked_unit)
        elsif check_message(message)
          super(message)
        else
          malformed_message_response
        end
      end

      def close(reason, reconnect = false)
        transmit(type: ActionCable::INTERNAL[:message_types][:disconnect],
                 reason: reason,
                 reconnect: reconnect
        )
        websocket.close
      end

      def malformed_message_response
        transmit(type: 'error',
                 message: 'malformed_message'
        )
      end

      def check_message(message)
        JSON.parse(message) rescue false
      end

      def setup_rate_limit
        self.rate_limit = self.class.rate_limit
        self.redis_config = self.class.redis_config
        if rate_limit
          self.redis = Redis.new(url: redis_config[:url])
          raise StandardError, 'Rate limiting: Slow down!. Try after some time' if check_block
        end
        true
      end

      def request_str
        headers_to_get = %w[SERVER_PROTOCOL SERVER_SOFTWARE REQUEST_METHOD REQUEST_PATH HTTP_USER_AGENT\
                            HTTP_CONNECTION HTTP_ORIGIN REMOTE_ADDR ORIGINAL_FULLPATH ORIGINAL_SCRIPT_NAME\
                            action_dispatch.authorized_host]
        headers = request.headers.to_h
        headers_to_get.map { |key| headers[key] }.join('-').gsub(' ', '')
      end
    end
  end
end
