# frozen_string_literal: true

module CableX
  module Cable
    module RateLimit
      ##
      # Process Rate Limit
      module CheckRateLimit
        def do_rate_limit
          check_rate_limit if rate_limit
        end

        def check_rate_limit
          check_unit('second') || check_unit('minute') || check_unit('hour')
        end

        def check_unit(unit)
          check_value = rate_limit[unit.to_s.to_sym]
          return unless check_value

          key = device_key unit
          redis_set key, 0, 1.send(unit) * 1000 unless redis_exists(key)
          redis_incr key
          block_connection = (redis_get(key) || -1).to_i >= check_value
          return unless block_connection

          block_device unit
        end
      end
    end
  end
end
