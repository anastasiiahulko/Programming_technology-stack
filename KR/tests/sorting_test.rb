require 'minitest/autorun'

class TestSortArray < Minitest::Test
  def test_sort_array_with_valid_numbers
    arr = [5, 3, 2, 4, 1, 10]
    expected_result = [1, 2, 3, 4, 5, 10]
    assert_equal expected_result, sort_array(arr)
  end

  def test_sort_array_with_invalid_elements
    arr = [5, 3, 'a', 4, 1, 10]
    assert_output("Помилка: масив містить некоректні елементи. Всі елементи повинні бути числами.\n") do
      assert_nil sort_array(arr)
    end
  end

  private

  def sort_array(arr)
    unless arr.all? { |elem| elem.is_a?(Numeric) }
      puts "Помилка: масив містить некоректні елементи. Всі елементи повинні бути числами."
      return nil # Повертаємо nil замість exit для тестування
    end
    arr.sort!
  end
end

