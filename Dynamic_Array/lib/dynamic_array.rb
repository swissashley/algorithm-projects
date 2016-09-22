require_relative "static_array"

class DynamicArray
  attr_reader :length

  def initialize
    @length = 0
    @capacity = 8
    @store = StaticArray.new(8)
  end

  # O(1)
  def [](index)
    check_index(index)
    @store[index]
  end

  # O(1)
  def []=(index, value)
    check_index(index)
    @store[index] = value
  end

  # O(1)
  def pop
    check_index(0)
    @length -= 1
    @store[length + 1]
  end

  # O(1) ammortized; O(n) worst case. Variable because of the possible
  # resize.
  def push(val)
    resize! if @length == @capacity
    @store[@length + 1] = val
    @length += 1
  end

  # O(n): has to shift over all the elements.
  def shift
    check_index(0)
    idx = 0
    first_el = @store[0]
    while idx < @length - 1
      @store[idx] = @store[idx + 1]
      idx += 1
    end
    @length -= 1
    first_el
  end

  # O(n): has to shift over all the elements.
  def unshift(val)
    resize! if @length == @capacity
    idx = @length
    while idx > 0
      @store[idx] = @store[idx - 1]
      idx -= 1
    end
    @store[0] = val
    @length += 1
    @store
  end

  protected
  attr_accessor :capacity, :store
  attr_writer :length

  def check_index(index)
    raise "index out of bounds" if (@length < index + 1 || index < 0)
  end

  # O(n): has to copy over all the elements to the new store.
  def resize!
    new_store = StaticArray.new(@capacity * 2)
    idx = 0
    while idx < @length
      new_store[idx] = @store[idx]
      idx += 1
    end
    @store = new_store
    @capacity *= 2
  end
end
