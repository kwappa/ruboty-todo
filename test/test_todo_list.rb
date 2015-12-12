require 'test/unit'
require 'ruboty/todo'

class TodoListTest < Test::Unit::TestCase
  self.test_order = :defined

  setup do

    @list = Ruboty::Todo::List.new(Ruboty::Brains::Memory.new)
  end

  sub_test_case 'when list has no item' do
    test 'list can add item' do
      assert_equal(@list.count, 0)
      @list.add(title: 'foo')
      assert_equal(@list.count, 1)
      assert_equal(@list[0].title, 'foo')
    end
  end

  sub_test_case 'when list has some items' do
    setup do
      @list.add(title: 'hoge')
      @list.add(title: 'piyo')
    end

    test 'list can remove item' do
      assert_equal(@list.count, 2)
      assert_equal(@list[0].title, 'hoge')
      @list[0].delete
      assert_equal(@list.count, 2)
      @list.cleanup
      assert_equal(@list.count, 1)
      assert_equal(@list[0].title, 'piyo')
    end
  end
end
