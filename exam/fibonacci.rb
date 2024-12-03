def fibonacci(n)
  unless n.is_a?(Integer)
    raise TypeError, "Очікується ціле число, отримано #{n.class}"
  end

  fib_sequence = []
  (0...n).each do |i|
    if i == 0
      fib_sequence << 0
    elsif i == 1
      fib_sequence << 1
    else
      fib_sequence << fib_sequence[i - 1] + fib_sequence[i - 2]
    end
  end
  fib_sequence
end

puts fibonacci(50).inspect if __FILE__ == $0
