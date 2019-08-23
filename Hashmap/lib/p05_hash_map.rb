require_relative 'p04_linked_list'

class HashMap
  attr_accessor :count
  include Enumerable
  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { LinkedList.new }
    @count = 0
  end

  def include?(key)
    i = key.hash % @store.length 
    @store[i].include?(key)

  end

  def set(key, val)
    i = key.hash % @store.length 
    if @store[i].include?(key)
      @store[i].update(key,val)
    else
      @count += 1
      resize! if @count > num_buckets
      @store[i].append(key, val)
    end 

  end

  def get(key)
     index = key.hash % @store.length 
    @store[index].each do |node|
      return node.val if node.key == key
    end 
  end

  def delete(key)
    i = key.hash % @store.length
    if @store[i].include?(key) 
      @store[i].remove(key)
      @count -= 1
    end
  end

  def each
    @store.each do |ll|
      ll.each do |node|
        yield [node.key, node.val]
      end
    end

  end

  # uncomment when you have Enumerable included
  # def to_s
  #   pairs = inject([]) do |strs, (k, v)|
  #     strs << "#{k.to_s} => #{v.to_s}"
  #   end
  #   "{\n" + pairs.join(",\n") + "\n}"
  # end

  alias_method :[], :get
  alias_method :[]=, :set

  private

  def num_buckets
    @store.length
  end

  def resize!
    arr = []
    self.each do |key, value|
      arr << [key, value]
    end
    @store = Array.new(num_buckets * 2) { LinkedList.new }  #o(1)
    @count = 1  #o(1)
    arr.each {|sub| self.set(sub.first, sub.last)}
  end

  def bucket(key)
    # optional but useful; return the bucket corresponding to `key`
  end
end
