module Ruboty
  module Todo
    class List
      class Item
        ATTRIBUTES = [:id, :title, :status, :dadline_at].freeze
        STATUSES   = [:not_yet, :doing, :done, :deleted].freeze

        ATTRIBUTES.each { |attr| attr_accessor attr }

        def initialize(id, params)
          self.id = id
          ATTRIBUTES.each { |attr| self.send("#{attr}=".to_sym, params[attr]) }
        end
      end

      extend Forwardable

      BLANK_LIST = {
        last_id: 0,
        items: [],
      }.freeze

      attr_reader :brain
      def_delegators :items, :count, :size, :[]

      def initialize(brain)
        @brain = brain
      end

      def items
        list[:items]
      end

      def add(params)
        items.push(Item.new(list[:last_id] += 1, params))
      end

      private

      def list
        brain.data['todo_list'] ||= default_list
      end

      def default_list
        BLANK_LIST.dup
      end
    end
  end
end
