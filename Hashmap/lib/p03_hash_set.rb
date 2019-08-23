class HashSet
  attr_accessor :count


  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(num)
    
    
    unless self.include?(num) 
      self.count += 1
      resize! if @count > num_buckets
      self[num] << num.hash 
      
      
    end 
  end

  def remove(num)
    if self.include?(num)
      self[num].delete(num.hash)
      self.count -= 1
    end 
  end

  def include?(num)
    self[num].include?(num.hash) 
  end

  private

  def [](num)
     i = num.hash % @store.length
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