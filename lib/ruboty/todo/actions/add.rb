module Ruboty
  module Todo
    module Actions
      class  Add < Base
        def call
          super
          message.reply(todo_list.add(title: message[:title]).format(new_item: true))
        end
      end
    end
  end
end
