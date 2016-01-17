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
    if @map.get(key)
      update_link!(@map.get(key))
      return @map.get(key).val
    else
      val = @prc.call(key)
      @store.insert(key, val)
      #also put in our @map

      @map.set(key, @store.last) #(key, node)
      eject!
      val
    end
  end

  def to_s
    "Map: " + @map.to_s + "\n" + "Store: " + @store.to_s
  end

  private

  def calc!(key)
    # suggested helper method; insert an (un-cached) key
  end

  def update_link!(link)
    link.prev.next = link.next
    link.next.prev = link.prev
    @store.tail.prev.next = link
    link.prev = @store.tail.prev
    @store.tail.prev = link
    link.next = @store.tail
    # suggested helper method; move a link to the end of the list
  end

  def eject!
    if @map.count > @max
      @map.delete(@store.first.key)
      @store.remove(@store.first.key)
    end
  end
end
