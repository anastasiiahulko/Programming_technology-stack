class Figure
  def area
    raise NotImplementedError, "Цей метод повинен бути реалізований у дочірніх класах"
  end
end

class Square < Figure
  def initialize(side)
    @side = side
  end

  def area
    @side ** 2
  end
end

class Triangle < Figure
  def initialize(base, height)
    @base = base
    @height = height
  end

  def area
    0.5 * @base * @height
  end
end

square = Square.new(4)
puts "Площа квадрата №1: #{square.area}" 

triangle = Triangle.new(5, 10)
puts "Площа трикутника №1: #{triangle.area}" 

square = Square.new(5)
puts "Площа квадрата №2: #{square.area}" 

triangle = Triangle.new(10, 6)
puts "Площа трикутника №2: #{triangle.area}" 
