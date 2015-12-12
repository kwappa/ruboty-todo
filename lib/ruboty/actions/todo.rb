module Ruboty
  module Actions
    class Todo < Base
      COMMANDS = %w[list help add start finish delete cleanup]
      attr_reader :todo_list

      def call
        (command, arg) = (message[:data] || '').split(/\s/, 2)
        command = parse_command(command)
        @todo_list = ::Ruboty::Todo::List.new(message.robot.brain)

        result = self.send(command, arg)
        message.reply(result)
      end

      def list(arg)
        todo_list.items.map(&:format).join(?\n)
      end

      def help(arg)
      end

      def add(arg)
        return '' if arg.to_s == ''
        todo_list.add(title: arg).format(new_item: true)
      end

      def start(arg)
      end

      def finish(arg)
      end

      def delete(arg)
      end

      def cleanup(arg)
      end

      private

      def parse_command(command)
        if COMMANDS.include?(command)
          command.to_sym
        else
          :list
        end
      end
    end
  end
end
