module ActionCable
  module Connection
    $last_message = nil
    class Base
      def transmit(message)
        $last_message = message
      end
    end
    class TestCase
      module Behavior
        def wait_for_async
          wait_for_executor Concurrent.global_io_executor
        end

        def run_in_eventmachine
          yield
          wait_for_async
        end

        def wait_for_executor(executor)
          # do not wait forever, wait 2s
          timeout = 2
          until executor.completed_task_count == executor.scheduled_task_count
            sleep 0.1
            timeout -= 0.1
            raise "Executor could not complete all tasks in 2 seconds" unless timeout > 0
          end
        end
        def send_message(message)
          connection.receive(message) if connection.respond_to?(:receive)
        end
        def last_message
          $last_message
        end
      end
    end
  end
end
