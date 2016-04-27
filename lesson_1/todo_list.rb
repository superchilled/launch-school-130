# todo_list.rb

require 'pry'

class Todo
  DONE_MARKER = 'X'
  UNDONE_MARKER = ' '

  attr_accessor :title, :description, :done

  def initialize(title, description='')
    @title = title
    @description = description
    @done = false
  end

  def done!
    self.done = true
  end

  def done?
    done
  end

  def undone!
    self.done = false
  end

  def to_s
    "[#{done? ? DONE_MARKER : UNDONE_MARKER}] #{title}"
  end
end

class TodoList
  attr_accessor :title

  def initialize(title)
    @title = title
    @todos = []
  end
  
  def add(todo)
    if todo.class != Todo
      raise TypeError, 'Can only add Todo objects'
    else 
      @todos << todo
    end
  end
  
  def <<(todo)
    if todo.class != Todo
      raise TypeError, 'Can only add Todo objects'
    else 
      @todos << todo
    end
  end

  def size
    @todos.length
  end

  def first
    @todos[0]
  end

  def last
    @todos.reverse[0]
  end

  def item_at(index)
    if index >= size
      raise IndexError
    else 
      @todos[index]
    end
  end

  def mark_done_at(index)
    item_at(index).done!
  end

  def mark_undone_at(index)
    item_at(index).undone!
  end

  def shift
    @todos.shift
  end

  def pop
    @todos.pop
  end

  def remove_at(index)
    if index >= size
      raise IndexError
    else 
      @todos.delete_at(index)
    end
  end

  def to_s
    @todos.each { |item| puts item.to_s }
  end

  def each
    counter = 0
  
    while counter < size
      yield(@todos[counter])
      counter += 1
    end
    self
  end

  def select
    new_list = TodoList.new(title)
    each { |item| new_list << item if yield(item) }
    new_list
  end

  def find_by_title(title)
    select { |item| item.title == title }.first
  end

  def all_done
    select { |item| item.done? }
  end
  
  def all_not_done
    select { |item| !item.done? }
  end

  def mark_done(title)
    select { |item| item.title == title }.first.done! 
  end

  def mark_all_done
    each { |item| item.done! }
  end

  def mark_all_undone
    each { |item| item.undone! }
  end
end

# given
todo1 = Todo.new("Buy milk")
todo2 = Todo.new("Clean room")
todo3 = Todo.new("Go to gym")
list = TodoList.new("Today's Todos")

# ---- Adding to the list -----

# add
list.add(todo1)                 # adds todo1 to end of list, returns list
list.add(todo2)                 # adds todo2 to end of list, returns list
list.add(todo3)                 # adds todo3 to end of list, returns list
# list.add(1)                     # raises TypeError with message "Can only add Todo objects"

# <<
# same behavior as add

# ---- Interrogating the list -----

# size
list.size                       # returns 3

# first
list.first                      # returns todo1, which is the first item in the list

# last
list.last                       # returns todo3, which is the last item in the list

# ---- Retrieving an item in the list ----

# item_at
# p list.item_at                    # raises ArgumentError
list.item_at(1)                 # returns 2nd item in list (zero based index)
# p list.item_at(100)               # raises IndexError

# ---- Marking items in the list -----

# mark_done_at
# p list.mark_done_at               # raises ArgumentError
list.mark_done_at(0)            # marks the 2nd item as done
# p list.mark_done_at(100)          # raises IndexError

# mark_undone_at
# list.mark_undone_at             # raises ArgumentError
# list.mark_undone_at(1)          # marks the 2nd item as not done,
# list.mark_undone_at(100)        # raises IndexError

# ---- Deleting from the the list -----

# shift
# p list.shift                      # removes and returns the first item in list

# pop
# p list.pop                        # removes and returns the last item in list

# remove_at
# list.remove_at                  # raises ArgumentError
# p list.remove_at(1)               # removes and returns the 2nd item
# list.remove_at(100)             # raises IndexError

# ---- Outputting the list -----

# to_s
# list.to_s                      # returns string representation of the list

# ---- Today's Todos ----
# [ ] Buy milk
# [ ] Clean room
# [ ] Go to gym

# or, if any todos are done

# ---- Today's Todos ----
# [ ] Buy milk
# [X] Clean room
# [ ] Go to gym

# list.each do |todo|
#   puts todo                   # calls Todo#to_s
# end

# results = list.select { |todo| todo.done? }    # you need to implement this method

# puts results.inspect

# results = list.find_by_title('Buy milk')   # you need to implement this method

# puts results.inspect

# results = list.all_done   # you need to implement this method

# puts results.inspect

# results = list.all_not_done   # you need to implement this method

# puts results.inspect

list.mark_done('Clean room')   # you need to implement this method

p list

# results = list.mark_all_done   # you need to implement this method

# puts results.inspect

# results = list.mark_all_undone   # you need to implement this method

# puts results.inspect

