class QuickSort
  # Quick sort has average case time complexity O(nlogn), but worst
  # case O(n**2).

  # Not in-place. Uses O(n) memory.
  def self.sort1(array)
    pivot = array.first
    left = []
    right = []
    left = array.select {|el| el < pivot}
    right = array.select {|el| el > pivot}
    self.class.sort1(left) + [pivot] + self.class.sort1(right)
  end

  # In-place.
  def self.sort2!(array, start = 0, length = array.length, &prc)
    
  end

  def self.partition(array, start, length, &prc)
    prc ||= Proc.new {|el1, el2| el1 <=> el2}
    pivot = array[start]
    pivot_idx = start
    (start + 1).upto(start + length - 1) do |idx|
      val = array[idx]
      if prc.call(val, pivot) == -1
        array[idx] = array[pivot_idx + 1]
        array[pivot_idx + 1] = pivot
        array[pivot_idx] = val
        pivot_idx += 1
      end
    end

    pivot_idx

  end
end
