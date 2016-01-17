require_relative 'p02_hashing'

class HashSet
  attr_reader :count

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(key)
    hashed_key = key.hash
    bucket_num = hashed_key % @store.length
    @store[bucket_num] << key unless include?(key)
    @count += 1
    resize! if @count >= @store.length
  end

  def include?(key)
    bucket_num = key.hash % @store.length
    @store[bucket_num].include?(key)
  end

  def remove(key)
    bucket_num = key.hash % @store.length
    @store[bucket_num].delete(key) if include?(key)
  end

  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
  end

  def num_buckets
    @store.length
  end

  def resize!
    flat_store = @store.flatten
    @store = Array.new(@store.length * 2) { Array.new }
    @count = 0
    flat_store.each do |el|
      insert(el)
    end
  end
end
