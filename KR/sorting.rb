def sort_array(arr)
  unless arr.all? { |elem| elem.is_a?(Numeric) }
    puts "Помилка: масив містить некоректні елементи. Всі елементи повинні бути числами."
    exit 
  end
  arr.sort!
end

arr = [5, 3, 2, 4, 1, 10]
puts sort_array(arr)

