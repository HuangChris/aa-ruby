class Fixnum
  # Fixnum#hash already implemented for you
end

class Array
  def hash
    hash = ""
    self.each do |el|
      hash +=  el.hash.abs.to_s
    end
    hash.to_i.hash
  end
end

class String
  def hash
    return self.ord.hash if self.length == 1
    self.split("").hash
  end
end

class Hash
  def hash
    array = self.to_a.flatten
    array.map! { |el| el.to_s }.sort!
    # p array
    array.hash
  end
end
