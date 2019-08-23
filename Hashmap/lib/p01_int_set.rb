class MaxIntSet
  attr_reader :max 
  attr_accessor :store
  def initialize(max)
    @max = max 
    @store = Array.new(@max, false)
  end

  def insert(num)
    if num >= 0 && num < @max
      @store[num] = true 
    else 
      raise "Out of bounds"
    end 
  end

  def remove(num)
    @store[num] = false
  end

  def include?(num)
    @store[num]
  end

  private

  def is_valid?(num)
  end

  def validate!(num)
  end
end


class IntSet
  attr_accessor :store
  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
  end

  def insert(num)
    i = num % @store.length
    @store[i] << num unless self.include?(num)
  end

  def remove(num)
    self[num].delete(num)
  end

  def include?(num)
    i = num % @store.length
    @store[i].include?(num)
  end

  private

  def [](num)
    i = num % @store.length
    @store[i]
  end

  def num_buckets
    @store.length
  end
end

class ResizingIntSet
  attr_accessor :count


  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(num)
    
    
    unless self.include?(num) 
      self.count += 1
      resize! if @count > num_buckets
      self[num] << num 
      
      
    end 
  end

  def remove(num)
    if self.include?(num)
      self[num].delete(num)
      self.count -= 1
    end 
  end

  def include?(num)
    self[num].include?(num)
  end

  private

  def [](num)
     i = num % @store.length
    @store[i]
  end

  def num_buckets
    @store.length
  end

  def resize!
      stored = @store.flatten #o(n)
      @store = Array.new(num_buckets * 2) { Array.new }  #o(1)
      @count = 1  #o(1)
      stored.each {|num| self.insert(num)}  #o(n)

    end
end
