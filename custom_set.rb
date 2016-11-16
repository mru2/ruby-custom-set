class CustomSet

  include Enumerable

  # O(n)
  def initialize(elements = [])
    @hash = elements.map { |e| [e, true] }.to_h
  end

  # O(1)
  def member?(e)
    @hash.key?(e)
  end

  # O(n)
  def each
    @hash.each { |k, _v| yield k }
  end

  # O(1)
  def empty?
    @hash.empty?
  end

  # O(n)
  def subset?(other)
    return true if empty?
    all? { |e| other.member?(e) }
  end

  # O(n)
  def disjoint?(other)
    return true if empty? || other.empty?
    intersection(other).empty?
  end

  # O(n)
  def ==(other)
    subset?(other) && other.subset?(self)
  end

  # O(1)
  def add(e)
    @hash[e] = true
    self
  end

  # O(n)
  def intersection(other)
    self.class.new(select { |e| other.member?(e) })
  end

  # O(n)
  def difference(other)
    self.class.new(reject { |e| other.member?(e) })
  end

  # O(n)
  def union(other)
    self.class.new(to_a + other.to_a)
  end

  def merge(other)
    @hash = (to_a + other.to_a).map { |e| [e, true] }.to_h
  end

end
