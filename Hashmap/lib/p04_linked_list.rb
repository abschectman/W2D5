require 'byebug'
class Node
  attr_reader :key
  attr_accessor :val, :next, :prev

  def initialize(key = nil, val = nil)
    @key = key
    @val = val
    @next = nil
    @prev = nil
  end

  def to_s
    "#{@key}: #{@val}"
  end

  def remove
    # optional but useful, connects previous link to next link
    # and removes self from list.
  end
end

class LinkedList
  attr_reader :tail, :head
  include Enumerable
  def initialize
    @head = Node.new
    @tail = Node.new
    @head.next = @tail
    @tail.prev = @head
  end

  def [](i)
    each_with_index { |link, j| return link if i == j }
    nil
  end

  def first
    @head.next
  end

  def last
    @tail.prev
  end

  def empty?
    @head.next == @tail
  end

  def get(key)
    self.each do |node|
      return node.val if node.key == key
    end
    nil
  end

  def include?(key)
    return true if !self.get(key).nil?
    false
  end

  def append(key, val)
   new_node = Node.new(key, val)
   old_last = self.last
   self.last.next = new_node
    @tail.prev = new_node
    new_node.next = @tail
    new_node.prev = old_last

  end

  def update(key, val)
    self.each do |node|
      if node.key == key
        node.val = val
      end
    end
  end

  def remove(key)
    self.each do |node|
      # debugger
      if node.key == key
        # debugger
        previous = node.prev
        # debugger
        next_node = node.next
        # debugger
        previous.next = next_node 
        next_node.prev = previous
      end
    end
  end

  def each
    current = self.first
    # debugger
    until current == self.tail
      # debugger
      yield current
      # debugger
      current = current.next
  
    end
  
    
  end

  # uncomment when you have `each` working and `Enumerable` included
  def to_s
    inject([]) { |acc, link| acc << "[#{link.key}, #{link.val}]" }.join(", ")
  end
end
