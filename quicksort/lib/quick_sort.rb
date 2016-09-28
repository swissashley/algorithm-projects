class QuickSort
  # Quick sort has average case time complexity O(nlogn), but worst
  # case O(n**2).

  # Not in-place. Uses O(n) memory.
  def self.sort1(array)
    return array if array.length < 2
    pivot = array.first
    left = []
    right = []
    left = array.select {|el| el < pivot}
    right = array.select {|el| el > pivot}
    sort1(left) + [pivot] + sort1(right)
  end

  # In-place.
  def self.sort2!(array, start = 0, length = array.length, &prc)
    prc ||= Proc.new {|el1, el2| el1 <=> el2}
    return array if length < 2

    pivot_idx = partition(array, start, length, &prc)
    sort2!(array, start, pivot_idx - start, &prc)
    sort2!(array, pivot_idx + 1, length - pivot_idx - 1 + start, &prc)
    array
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
