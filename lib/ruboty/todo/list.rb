module Ruboty
  module Todo
    class List
      extend Forwardable

      attr_reader :brain
      def_delegators :items, :count, :size, :[]

      def initialize(brain)
        @brain = brain
      end

      def next_id
        list[:last_id] += 1
      end

      def items
        list[:items]
      end

      def add(params)
        item = Item.new(next_id, params)
        items.push(item)
        item
      end

      def cleanup
        list[:items] = list[:items].reject { |item| item.deleted? }
      end

      def find(id)
        items.find { |item| item.id == id }
      end

      private

      def list
        brain.data['todo_list'] ||= { last_id: 0, items: [] }
      end
    end
  end
end
