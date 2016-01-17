class Link
  attr_accessor :key, :val, :next, :prev

  def initialize(key = nil, val = nil)
    @key = key
    @val = val
    @next = nil
    @prev = nil
  end

  def to_s
    "#{@key}: #{@val}"
  end
end

class LinkedList
  include Enumerable

  attr_accessor :head, :tail

  def initialize
    @head = Link.new
    @tail = Link.new
    @head.next = @tail
    @tail.prev = @head
  end

  def [](i)
    each_with_index { |link, j| return link if i == j }
    nil
  end

  def first
    @head.next
  end

  def last
    @tail.prev
  end

  def empty?
    @head.next == @tail
  end

  def get(key)
    current_node = @head
    until current_node.next.nil?
      return current_node.val if current_node.key == key
      current_node = current_node.next
    end
    nil
  end

  def include?(key)
    search_result = get(key)
    !search_result.nil?
  end

  def insert(key, val)
    remove(key) if include?(key)
    new_node = Link.new(key, val)
    @tail.prev.next = new_node
    new_node.prev = @tail.prev
    new_node.next = @tail
    @tail.prev = new_node
  end

  def remove(key)
    return nil unless include?(key)
    current_node = @head
    until current_node.next.nil?
      if current_node.key == key
        current_node.next.prev = current_node.prev
        current_node.prev.next = current_node.next
        return true
      end
      current_node = current_node.next
    end
  end

  def each(&blk)
    current_node = @head.next
    until current_node.next.nil?
      blk.call(current_node)
      current_node = current_node.next
    end
    self
  end

  # uncomment when you have `each` working and `Enumerable` included
  # def to_s
  #   inject([]) { |acc, link| acc << "[#{link.key}, #{link.val}]" }.join(", ")
  # end
end
