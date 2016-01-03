module Ruboty
  module Todo
    module Actions
      class List < Base
        def call
          super
          message.reply(send(message[:command].to_sym))
        end

        def list
          todo_list.items.map(&:format).join(?\n)
        end

        def cleanup
          todo_list.gc
          todo_list.renum
          list
        end

        def gc
          todo_list.gc
          list
        end

        def renum
          todo_list.renum
          list
        end
      end
    end
  end
end
