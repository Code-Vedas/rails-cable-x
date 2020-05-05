# frozen_string_literal: true

module CableX
  module Cable
    module RateLimit
      ##
      # Process Rate Limit
      module BlockCheck
        def check_block
          check_block_unit('second') || check_block_unit('minute') || check_block_unit('hour') if rate_limit
        end

        def check_block_unit(unit)
          unit if redis_exists block_device_key(unit)
        end

        def block_device(unit)
          redis_set block_device_key(unit), true, rate_limit[:cool_down].send('second') * 1000
          unit
        end

        def disconnect_client(unit)
          close("Rate limiting: Limit exceeded for per #{unit} Slow down!. Try after some time", false)
        end
      end
    end
  end
end
# "Rate limiting: Slow down!. Try after some time"
