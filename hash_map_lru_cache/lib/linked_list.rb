class Link

  attr_accessor :key, :val, :prev, :next

  def initialize(key = nil, val = nil)
    @key = key
    @val = nil
    @next = nil
    @prev = nil
  end

  def to_s
    "#{@key} : #{@val}"
  end

end

class LinkedList
  include Enumerable

  attr_accessor :head, :tail

  def initialize
    @head = Link.new
    @tail = Link.new
    @head.next = @tail
    @tail.next = @head
  end

  def first
    @head.next
  end

  def last
    @tail.prev
  end

  def each
    link = first
    while link != @tail
      proc.call(link)
      link = link.next
    end
  end
end
