module Ruboty
  module Todo
    class Item
      ATTRIBUTES = [:id, :title, :status, :deadline_at].freeze
      STATUSES   = [:not_yet, :doing, :done, :deleted].freeze
      EMOTICONS  = {
        new:     'new',
        not_yet: 'memo',
        doing:   'rocket',
        done:    'tada',
        deleted: 'x',
      }

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

      def format(new_item: false)
        emoticon_state = new_item ? :new : status

        "[#{sprintf('%2d', id)}] :#{EMOTICONS[emoticon_state]}: #{title}"
      end
    end
  end
end
