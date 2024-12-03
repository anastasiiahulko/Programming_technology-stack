require 'minitest/autorun'
require_relative 'fibonacci'

class FibonacciTest < Minitest::Test
  def test_fibonacci_zero
    assert_equal [], fibonacci(0)
  end

  def test_fibonacci_one
    assert_equal [0], fibonacci(1)
  end

  def test_fibonacci_two
    assert_equal [0, 1], fibonacci(2)
  end

  def test_fibonacci_five
    assert_equal [0, 1, 1, 2, 3], fibonacci(5)
  end

  def test_fibonacci_ten
    expected_sequence = [0, 1, 1, 2, 3, 5, 8, 13, 21, 34]
    assert_equal expected_sequence, fibonacci(10)
  end

  def test_fibonacci_negative
    assert_equal [], fibonacci(-5)
  end

  def test_fibonacci_non_integer
    assert_raises(TypeError) { fibonacci('a') }
  end
end
