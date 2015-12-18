module Ruboty
  module Handlers
    class Todo < Base
      on(
        /(?<command>list|cleanup|renum) todos\z/,
         name: 'list',
         description: '(list|cleanup|renum) all todo items'
      )

      on(
        /add todo (?<title>.+)\z/,
        name: 'add',
        description: 'add todo item'
      )

      on(
        /(?<state>start|finish|delete) todo (?<id>\d+)\z/,
         name: 'state',
         description: 'change state of todo item'
      )

      def list(message)
        ::Ruboty::Todo::Actions::List.new(message).call
      end

      def add(message)
        ::Ruboty::Todo::Actions::Add.new(message).call
      end

      def state(message)
        ::Ruboty::Todo::Actions::State.new(message).call
      end
    end
  end
end
