module Ruboty
  module Todo
    module Actions
      class State < Base
        def call
          super
          message.reply(change_item_state(message[:id].to_i, message[:state].to_sym))
        end

        private

        def change_item_state(id, state)
          item = find_item(id)
          return "item #{id} is not found" if item.nil?
          item.send(state)
          item.format
        end
      end
    end
  end
end
