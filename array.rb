class Array
  alias_method :original_brackets, :[]
  
  def [](index)
    return "\0" if index.abs >= size
    original_brackets(index)
  end
  
  alias_method :original_map, :map
  
  def map(*args, &block)
    if args.empty?
      original_map(&block)
    else
      sequence = args.first
      sequence = sequence.to_a if sequence.is_a?(Range)
      sequence.map { |i| i = size + i if i < 0; self[i] if i >= 0 && i < size }.compact.map(&block)
    end
  end
end


b = ["cat", "bat", "mat", "sat"]
# print b.map(-10..10) { |x| x[0].upcase + x[1, x.length] }, "\n"

result = b.map(-10..10) { |x| x[0].upcase + x[1, x.length] }
print result.map { |x| x == "\0" ? "NULL" : x }, "\n"

a = [1, 2, 34, 5]
raise "Test case 1 failed" unless a[1] == 2
raise "Test case 2 failed" unless a[10] == "\0"
raise "Test case 3 failed" unless a.map(2..4) { |i| i.to_f } == [34.0, 5.0]
raise "Test case 4 failed" unless a.map { |i| i.to_f } == [1.0, 2.0, 34.0, 5.0]

b = ["cat", "bat", "mat", "sat"]
raise "Test case 5 failed" unless b[-1] == "sat"
raise "Test case 6 failed" unless b[5] == "\0"
raise "Test case 7 failed" unless b.map(2..10) { |x| x[0].upcase + x[1, x.length] } == ["Mat", "Sat"]
raise "Test case 8 failed" unless b.map(2..4) { |x| x[0].upcase + x[1, x.length] } == ["Mat", "Sat"]
raise "Test case 9 failed" unless b.map(-3..-1) { |x| x[0].upcase + x[1, x.length] } == ["Bat", "Mat", "Sat"]
raise "Test case 10 failed" unless b.map { |x| x[0].upcase + x[1, x.length] } == ["Cat", "Bat", "Mat", "Sat"]

puts "All test cases passed!"