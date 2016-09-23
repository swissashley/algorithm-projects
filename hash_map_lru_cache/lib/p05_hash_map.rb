require_relative 'p02_hashing'
require_relative 'p04_linked_list'

class HashMap
  include Enumerable

  attr_reader :count

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { LinkedList.new }
    @count = 0
  end

  def include?(key)
    bucket(key).include?(key)
  end

  def set(key, val)
    resize! if @count == num_buckets
    unless include?(key)
      @count += 1
    end
    bucket(key).remove(key)
    bucket(key).insert(key, val)
  end

  def get(key)
    return bucket(key).get(key)
    nil
  end

  def delete(key)
    if include?(key)
      bucket(key).remove(key)
      @count -= 1
    end
    nil
  end

  def each
    @store.each do |bucket|
      bucket.each do |link|
        proc.call(link.key, link.val)
      end
    end
  end

  # uncomment when you have Enumerable included
  def to_s
    pairs = inject([]) do |strs, (k, v)|
      strs << "#{k.to_s} => #{v.to_s}"
    end
    "{\n" + pairs.join(",\n") + "\n}"
  end

  alias_method :[], :get
  alias_method :[]=, :set

  private

  def num_buckets
    @store.length
  end

  def resize!
    new_store = Array.new(num_buckets * 2) { LinkedList.new }
    @store.each do |bucket|
      bucket.each do |link|
        new_store[link.key.hash % (num_buckets * 2)].insert(link.key, link.val)
      end
    end
    @store = new_store
  end

  def bucket(key)
    # optional but useful; return the bucket corresponding to `key`
    @store[key.hash % num_buckets]
  end
end
