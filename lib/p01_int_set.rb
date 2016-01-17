class MaxIntSet
  def initialize(max)
    @store = Array.new(max, false)
  end

  def insert(num)
    validate!(num)
    @store[num] = true
  end

  def remove(num)
    validate!(num)
    @store[num] = false
  end

  def include?(num)
    validate!(num)
    @store[num]
  end

  private

  def is_valid?(num)
    num.between?(0,@store.length)
  end

  def validate!(num)
    raise "Out of bounds" unless is_valid?(num)
  end
end


class IntSet
  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
  end

  def insert(num)
    bucket_num = num % @store.length
    @store[bucket_num] << num unless include?(num)
  end

  def remove(num)
    bucket_num = num % @store.length
    @store[bucket_num].delete(num) if include?(num)
  end

  def include?(num)
    bucket_num = num % @store.length
    @store[bucket_num].include?(num)
  end

  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
  end

  def num_buckets
    @store.length
  end
end

class ResizingIntSet
  attr_reader :count

  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(num)
    return false if include?(num)
    @count += 1
    bucket_num = num % @store.length
    @store[bucket_num] << num
    resize! if @count >= @store.length
  end

  def remove(num)
    return false unless include?(num)
    @count -= 1
    bucket_num = num % @store.length
    @store[bucket_num].delete(num)
  end

  def include?(num)
    bucket_num = num % @store.length
    @store[bucket_num].include?(num)
  end

  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
  end

  def num_buckets
    @store.length
  end

  def resize!
    new_array = @store.flatten
    @store = Array.new(@store.length * 2) { Array.new }
    @count = 0
    new_array.each do |el|
      insert(el)
    end
  end
end
