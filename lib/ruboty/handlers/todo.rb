module Ruboty
  module Handlers
    class Todo < Base
      on(/todo(\s*)?(?<data>.+)?/, name: 'todo', description: 'todo')

      def todo(message)
        ::Ruboty::Actions::Todo.new(message).call
      end
    end
  end
end
