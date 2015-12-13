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
      assert_equal(@list[0].id, 1)
    end
  end

  sub_test_case 'when list has some items' do
    setup do
      @list.add(title: 'hoge')
      @list.add(title: 'piyo')
    end

    test 'list can change status of items' do
      assert_equal(@list[0].status, :not_yet)
      @list[0].start
      assert_true(@list[0].doing?)
      @list[1].finish
      assert_true(@list[1].done?)
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

    test 'list can renum id' do
      @list[0].delete
      @list.cleanup
      assert_equal(@list[0].id, 2)
      @list.renum
      assert_equal(@list[0].id, 1)
    end

    test 'item can set deadline' do
      @list[0].deadline = '13:45'
      @list[1].deadline = 'INVALIDD STRING'
      today = Date.today
      assert_equal(@list[0].deadline_at, Time.local(today.year, today.month, today.day, 13, 45))
      assert_nil(@list[1].deadline_at)
    end
  end
end
