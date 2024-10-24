class Student
  attr_accessor :name, :age, :grades

  def initialize(name, age, grades)
    @name = name
    @age = age
    @grades = grades
  end

  def average_grade
    raise ArgumentError, "Список оцінок #{@name}, #{@age} містить некоректні значення. Всі оцінки повинні бути числами." if grades.any? { |grade| !grade.is_a?(Numeric) }
    
    return "non grades" if @grades.empty?
    @grades.sum / @grades.size
  end

  def info
    begin
      puts("#{@name}, #{@age}, #{average_grade}")
    rescue ArgumentError => e
      puts "Виникла помилка: #{e.message}"
    end
  end
end

begin
  student1 = Student.new("Alex", 20, [10, 20, 58, 1, 36])
  student1.info
rescue => e
  puts "Виникла помилка: #{e.message}"
end

begin
  student2 = Student.new("Bob", 18, [25, "a", 100, 17, 5])
  student2.info
rescue => e
  puts "Виникла помилка: #{e.message}"
end
