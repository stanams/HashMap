class Fixnum
  # Fixnum#hash already implemented for you
end

class Array
  def hash
    hashable_num = 0
    self.each_with_index do |value, index|
      hashable_num += value.hash * index.hash
    end
    (hashable_num % (10 ** 20)).hash
  end
end

class String
  def hash
    self.split("").map{ |letter| letter.ord }.hash
  end
end

class Hash
  def hash
    hashable_num = 0
    self.keys.each do |key|
      hashable_num += key.to_s.hash
      hashable_num += self[key].to_s.hash
    end
    (hashable_num % (10 ** 20)).hash
  end
end
