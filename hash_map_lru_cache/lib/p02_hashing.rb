class Fixnum
  # Fixnum#hash already implemented for you
end

class Array
  def hash
    num = 75674793
    self.each do |el|
      num += num ^ el.hash
    end
    num
  end
end

class String
  def hash
    self.split('').map(&:ord).hash
  end
end

class Hash
  # This returns 0 because rspec will break if it returns nil
  # Make sure to implement an actual Hash#hash method
  def hash
    self.keys.sort.map(&:to_s).map(&:ord).hash
  end
end
