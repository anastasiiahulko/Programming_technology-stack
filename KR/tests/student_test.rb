require 'minitest/autorun'
require_relative '../student'

class TestStudent < Minitest::Test
  def setup
    @student1 = Student.new("Alex", 20, [10, 20, 58, 1, 36])
    @student2 = Student.new("Bob", 18, [25, "a", 100, 17, 5])
    @student3 = Student.new("Charlie", 19, [])
    @student4 = Student.new("Daisy", 21, [15, 25, 30, 20])
  end

  def test_average_grade_valid_grades
    assert_equal 25, @student1.average_grade
  end

  def test_average_grade_invalid_grades
    assert_raises(ArgumentError) { @student2.average_grade }
  end

  def test_average_grade_empty_grades
    assert_equal "non grades", @student3.average_grade
  end

  def test_info_output
    assert_output("Alex, 20, 25\n") { @student1.info }
    assert_output("Daisy, 21, 22\n") { @student4.info }
  end

  def test_info_output_with_invalid_grades
    assert_output("Виникла помилка: Список оцінок Bob, 18 містить некоректні значення. Всі оцінки повинні бути числами.\n") do
      @student2.info
    end
  end
end
