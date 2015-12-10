module Ruboty
  module Todo
    class List
      extend Forwardable

      COLUMNS = [:id, :title, :status, :dadline_at].freeze
      STATUS  = [:not_yet, :doing, :done, :deleted].freeze

      BLANK_LIST = {
        last_id: 0,
        todos: [],
      }.freeze

      BLANK_TODO = {
        id: 0,
        title: '',
        status: :not_yet,
        deadline_at: nil,
      }.freeze

      attr_reader :brain
      def_delegators :all, :count, :size, :[]

      def initialize(brain)
        @brain = brain
      end

      def all
        list[:todos]
      end

      def add(params)
        new_todo = COLUMNS.each_with_object(blank_todo) do |column, todo|
          todo[column] = params[column]
        end
        new_todo[:id] = list[:last_id] += 1
        list[:todos].push(new_todo)
      end

      private

      def list
        brain.data['todo_list'] ||= default_list
      end

      def default_list
        BLANK_LIST.dup
      end

      def blank_todo
        BLANK_TODO.dup
      end
    end
  end
end
