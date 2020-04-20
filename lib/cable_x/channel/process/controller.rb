# frozen_string_literal: true

module CableX
  module Channel
    module Process
      ##
      # Process controller specific tasks
      module Controller
        def set_controller
          set_controller_hash
        end

        def invoke_controller
          set_controller
          set_request
          set_response
          controller_klass.dispatch(controller_action_hash[:action], request, response)
        end

        def set_controller_hash
          @controller_action_hash = Rails.application.routes.recognize_path data['path'], { method: data['method'] }
        end

        def controller_klass
          controller_klass_name = controller_action_hash[:controller].split('/').map(&:camelize).join('::')
          "#{controller_klass_name}Controller".constantize
        end
      end
    end
  end
end
