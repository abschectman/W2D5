class Integer
  # Integer#hash already implemented for you
end

class Array
  def hash
    string = ""
    self.flatten.each do |el|
      string += el.hash.abs.to_s
    end
    string.to_i
   
  end
end

class String
  def hash
  end
end

class Hash
  # This returns 0 because rspec will break if it returns nil
  # Make sure to implement an actual Hash#hash method
  def hash
    0
  end
end
