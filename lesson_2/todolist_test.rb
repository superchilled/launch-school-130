# todolist_test.rb

require 'minitest/autorun'
require "minitest/reporters"
Minitest::Reporters.use!

require_relative 'todolist'

class TodoListTest < MiniTest::Test

  def setup
    @todo1 = Todo.new("Buy milk")
    @todo2 = Todo.new("Clean room")
    @todo3 = Todo.new("Go to gym")
    @todos = [@todo1, @todo2, @todo3]

    @list = TodoList.new("Today's Todos")
    @list.add(@todo1)
    @list.add(@todo2)
    @list.add(@todo3)
  end

  def test_to_a
    assert_equal(@todos, @list.to_a)
  end
  
  def test_size
    assert_equal(3, @todos.size)
  end

  def test_first
    assert_equal(@todo1, @list.first)
  end

  def test_last
    assert_equal(@todo3, @list.last)
  end

  def test_shift
    assert_equal(@todo1, @list.shift)
    assert_equal(2, @list.size)
  end

  def test_pop
    assert_equal(@todo3, @list.pop)
    assert_equal([@todo1, @todo2], @list.to_a)
  end

  def test_done?
    refute(@list.done?)
  end

  def test_list_type_error
    assert_raises(TypeError) { @list.add('Some string') }
    assert_raises(TypeError) { @list.<<(1) }
  end

  def test_item_at
    assert_equal(@list.item_at(0), @todo1)
    assert_raises(IndexError) { @list.item_at(100) }
  end

  def test_mark_done_at
    @list.mark_done_at(0)
    assert(@todo1.done?)
    assert_raises(IndexError) { @list.mark_done_at(100) }
  end

  def test_mark_undone_at
    @todo1.done!
    @list.mark_undone_at(0)
    refute(@todo1.done?)
    assert_raises(IndexError) { @list.mark_undone_at(100) }
  end

  def test_done!
    @list.done!
    assert(@todo1.done?)
    assert(@todo2.done?)
    assert(@todo3.done?)
  end

  def test_remove_at
    assert_equal(@todo1, @list.remove_at(0))
    assert_equal([@todo2, @todo3], @list.to_a)
    assert_raises(IndexError) { @list.remove_at(100) }
  end

  def test_to_s
    output = <<-OUTPUT.chomp.gsub /^\s+/, ""
    ---- Today's Todos ----
    [ ] Buy milk
    [ ] Clean room
    [ ] Go to gym
    OUTPUT
  
    assert_equal(output, @list.to_s)
  end

  def test_to_s_one_done
    @list.mark_done_at(0)
    assert(@todo1.done?)
    output = <<-OUTPUT.chomp.gsub /^\s+/, ""
    ---- Today's Todos ----
    [X] Buy milk
    [ ] Clean room
    [ ] Go to gym
    OUTPUT
  
    assert_equal(output, @list.to_s)
  end

  def test_to_s_all_done
    @list.done!
    assert(@todo1.done?)
    assert(@todo2.done?)
    assert(@todo3.done?)
    output = <<-OUTPUT.chomp.gsub /^\s+/, ""
    ---- Today's Todos ----
    [X] Buy milk
    [X] Clean room
    [X] Go to gym
    OUTPUT
  
    assert_equal(output, @list.to_s)
  end

  def test_each
    @list.each { |todo| todo.done! }
    assert(@todo1.done?)
    assert(@todo2.done?)
    assert(@todo3.done?)
  end

  def test_each_return
    assert_equal(@list, @list.each { 'Do nothing' })
  end

  def test_select
    new_list = @list.select { |item| item.title == 'Buy milk' }
    assert_equal(@todo1, new_list.item_at(0))
  end
end
