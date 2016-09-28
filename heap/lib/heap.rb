class BinaryMinHeap
  def initialize(&prc)
    @store = []
    @prc = prc
  end

  def count
    @store.length
  end

  def extract
    val = @store[0]
    @store[0] ,@store[-1] = @store[-1], @store[0]
    @store.pop
    self.class.heapify_down(@store, 0, @prc)
    val
  end

  def peek
    @store[0]
  end

  def push(val)
    @store.push(val)
    self.class.heapify_up(@store, count - 1, &prc)
  end

  protected
  attr_accessor :prc, :store

  public
  def self.child_indices(len, parent_index)
    [parent_index * 2 + 1, parent_index * 2 + 2].select {|idx| idx < len}
  end

  def self.parent_index(child_index)
    raise "root has no parent" if child_index == 0
    (child_index - 1) / 2
  end

  def self.heapify_down(array, parent_idx, len = array.length, &prc)
    prc ||= Proc.new { |el1, el2| el1 <=> el2 }
    return array if parent_idx == array.length

    child_idx = child_indices(array.length, parent_idx).min
    if prc.call(array[child_idx], array[parent_idx]) == 1
      array[parent_idx], array[child_idx] = array[child_idx], array[parent_idx]
      heapify_down(array, child_idx, len, &prc)
    else
      return array
    end
  end

  def self.heapify_up(array, child_idx, len = array.length, &prc)
    prc ||= Proc.new { |el1, el2| el1 <=> el2 }
    return array if child_idx == 0

    parent_idx = parent_index(child_idx)
    if prc.call(array[child_idx], array[parent_idx]) == -1
      array[parent_idx], array[child_idx] = array[child_idx], array[parent_idx]
      heapify_up(array, parent_idx, len, &prc)
    else
      return array
    end
  end
end
