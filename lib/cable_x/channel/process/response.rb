# frozen_string_literal: true

module CableX
  module Channel
    module Process
      ##
      # Process response specific tasks
      module Response
        def set_response
          @response = ActionDispatch::Response.new
        end

        def prepare_response
          @response_body = { request_id: request_id, body: response.body, code: response.code, headers: response.headers.to_h }
        end
      end
    end
  end
end
