require 'test/unit'
require 'ruboty/todo'

class TodoListTest < Test::Unit::TestCase
  self.test_order = :defined

  def setup
    @list = Ruboty::Todo::List.new(Ruboty::Brains::Memory.new)
  end

  sub_test_case 'when list has no item' do
    test 'list can add todo' do
      assert_equal(@list.count, 0)
      @list.add(title: 'foo')
      assert_equal(@list.count, 1)
      assert_equal(@list[0][:title], 'foo')
    end
  end
end