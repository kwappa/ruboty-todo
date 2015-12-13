module Ruboty
  module Actions
    class Todo < Base
      COMMANDS = %w[list help add start finish delete cleanup renum]
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
<<EOH
  `todo list`
    show todo list
  `todo add [TITLE]`
    add list to new todo
  `todo start [ID}`
    start todo
  `todo finish [ID]`
    finish todo (will removed by `cleanup`)
  `todo delete [ID]`
    remove todo (will removed by `cleanup`)
  `todo cleanup`
    delete finished and deleted items from list
  `todo renum`
    renum id from 1
  `todo help`
    show this help
EOH
      end

      def add(arg)
        return 'specify todo tilte like `todo add [TITLE]`' if title == ''
        todo_list.add(title: title).format(new_item: true)
      end

      def start(arg)
        change_item_state(arg, :start)
      end

      def finish(arg)
        change_item_state(arg, :finish)
      end

      def delete(arg)
        change_item_state(arg, :delete)
      end

      def cleanup(arg)
        todo_list.cleanup
        list(arg)
      end

      def renum(arg)
        todo_list.renum
        list(arg)
      end

      private

      def change_item_state(arg, status)
        item = find_item(arg)
        return "item #{arg} is not found" if item.nil?
        item.send(status)
        item.format
      end

      def find_item(arg)
        id = arg.to_i
        item = todo_list.find(arg.to_i)
      end

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
