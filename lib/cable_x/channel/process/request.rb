# frozen_string_literal: true

module CableX
  module Channel
    module Process
      ##
      # Process request specific tasks
      module Request
        def set_request
          @request_id = data['request_id']
          @request = ActionDispatch::Request.new({})
          @request.headers = data['headers'] if data['headers']
          @request.request_parameters = controller_action_hash.merge(data['params'] || {}).merge(data['data'] || {})
          @request.request_method = data['method'].upcase
        end
      end
    end
  end
end
