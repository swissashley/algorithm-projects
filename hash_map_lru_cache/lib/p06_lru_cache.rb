require_relative 'p05_hash_map'
require_relative 'p04_linked_list'

class LRUCache
  attr_reader :count
  def initialize(max, prc)
    @map = HashMap.new
    @store = LinkedList.new
    @max = max
    @prc = prc
  end

  def count
    @map.count
  end

  def get(key)
    link = @map[key]
    unless link.nil?
      update_link!(link)
      return link.val
    else
      set!(key)
    end

  end

  def to_s
    "Map: " + @map.to_s + "\n" + "Store: " + @store.to_s
  end

  private

  def set!(key)
    # suggested helper method; insert an (un-cached) key
    val = @prc.call(key)
    @store.insert(key, val)
    @map[key] = @store.last
    eject! if count > @max
    return val
  end

  def update_link!(link)
    # suggested helper method; move a link to the end of the list
    link.prev.next = link.next
    link.next.prev = link.prev
    @store.insert(link.key, link.val)
  end

  def eject!
    key = @store.first.key
    @store.remove(key)
    @map.delete(key)
    nil
  end
end
