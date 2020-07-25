# frozen_string_literal: true

module CableX
  module Cable
    module RateLimit
      ##
      # Process Rate Limit
      module RateLimitRedis
        def redis_set(key, value, expire_millisecond)
          redis.set key, value, px: expire_millisecond
        end

        def redis_incr(key)
          redis.incr key
        end

        def redis_exists(key)
          redis.exists? key
        end

        def redis_get(key)
          redis.get key
        end

        def device_key(schedule)
          "#{redis_config[:channel_prefix]}-rl-#{schedule}-#{device_id}"
        end

        def block_device_key(schedule)
          "#{redis_config[:channel_prefix]}-rl-block-#{schedule}-#{device_id}"
        end
      end
    end
  end
end
