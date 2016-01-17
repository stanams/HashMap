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
    bucket_num = key.hash % @store.length
    @store[bucket_num].include?(key)
  end

  def set(key, val)
    bucket_num = key.hash % @store.length
    @store[bucket_num].insert(key, val)
    @count += 1
    resize! if @count >= @store.length
  end

  def get(key)
    return nil unless include?(key)
    bucket_num = key.hash % @store.length
    @store[bucket_num].get(key)
  end

  def delete(key)
    return nil unless include?(key)
    bucket_num = key.hash % @store.length
    @store[bucket_num].remove(key)
    @count -= 1
  end

  def each(&blk)
    @store.each do |list|
      list.each do |node|
        blk.call(node.key, node.val)
      end
    end
    self
  end

  # uncomment when you have Enumerable included
  # def to_s
  #   pairs = inject([]) do |strs, (k, v)|
  #     strs << "#{k.to_s} => #{v.to_s}"
  #   end
  #   "{\n" + pairs.join(",\n") + "\n}"
  # end

  alias_method :[], :get
  alias_method :[]=, :set

  private

  def num_buckets
    @store.length
  end

  def resize!
    old_store = @store
    @store = Array.new(@store.length * 2) { LinkedList.new }
    @count = 0
    old_store.each do |list|
      list.each do |node|
        set(node.key, node.val)
      end
    end
  end

  def bucket(key)
    # optional but useful; return the bucket corresponding to `key`
  end
end
