module Ruboty
  module Todo
    class List
      class Item
        ATTRIBUTES = [:id, :title, :status, :deadline_at].freeze
        STATUSES   = [:not_yet, :doing, :done, :deleted].freeze

        ATTRIBUTES.each { |attr| attr_accessor attr }

        def initialize(id, params)
          self.id = id
          self.status = :not_yet
          ATTRIBUTES.each do |attr|
            self.send("#{attr}=".to_sym, params[attr]) if params.key?(attr)
          end
        end

        def start
          self.status = :doing
        end

        def doing?
          self.status == :doing
        end

        def finish
          self.status = :done
        end

        def done?
          self.status == :done
        end

        def delete
          self.status = :deleted
        end

        def deleted?
          self.status == :deleted
        end

        def deadline=(deadline)
          self.deadline_at = Time.parse(deadline) rescue nil
        end
      end

      extend Forwardable

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

      def cleanup
        list[:items] = list[:items].reject { |item| item.deleted? }
      end

      private

      def list
        brain.data['todo_list'] ||= { last_id: 0, items: [] }
      end
    end
  end
end
