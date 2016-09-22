require_relative "static_array"

class RingBuffer
  attr_reader :length

  def initialize
    @length = 0
    @capacity = 8
    @start_idx = 0
    @store = StaticArray.new(@capacity)
  end

  # O(1)
  def [](index)
    check_index(index)
    ring_index = (index + @start_idx) % @capacity
    @store[ring_index]
  end

  # O(1)
  def []=(index, val)
    check_index(index)
    ring_index = (index + @start_idx) % @capacity
    @store[ring_index] = val
  end

  # O(1)
  def pop
    check_index(0)
    @length -= 1;
    val = @store[(@length + @start_idx) % @capacity]
    @store[(@length + @start_idx) % @capacity] = nil
    val
  end

  # O(1) ammortized
  def push(val)
    resize! if @length == @capacity
    @store[(@length + @start_idx) % @capacity] = val
    @length += 1
  end

  # O(1)
  def shift
    check_index(0)
    val = @store[@start_idx]
    @store[@start_idx] = nil
    @start_idx = (@start_idx + 1) % @capacity
    @length -= 1
    val
  end

  # O(1) ammortized
  def unshift(val)
    resize! if @length == @capacity
    @start_idx = (@start_idx - 1) % @capacity
    @store[@start_idx] = val
    @length += 1
    val
  end

  protected
  attr_accessor :capacity, :start_idx, :store
  attr_writer :length

  def check_index(index)
    raise "index out of bounds" if (index < 0 || index > @length - 1)
  end

  def resize!
    new_store = StaticArray.new(@capacity * 2)
    idx = 0
    while idx < @length
      new_store[idx] = @store[(@start_idx + idx) % @capacity]
      idx += 1
    end
    @store = new_store
    @start_idx = 0
    @capacity *= 2
  end
end
