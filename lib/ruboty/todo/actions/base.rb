module Ruboty
  module Todo
    module Actions
      class  Base < ::Ruboty::Actions::Base
        attr_reader :todo_list

        def call
          @todo_list = ::Ruboty::Todo::List.new(message.robot.brain)
        end

        private

        def from_owner?
          return true if ENV['TODO_OWNERS'] == 'IGNORE_CHECK'
          ENV['TODO_OWNERS'].split(',').map(&:strip).include?(message.from_name)
        end

        def find_item(arg)
          id = arg.to_i
          item = todo_list.find(arg.to_i)
        end
      end
    end
  end
end
