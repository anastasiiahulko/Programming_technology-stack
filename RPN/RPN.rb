def if_integer(element, result_stack)
    #функція додавання числа до стеку кінцевого результату
    result_stack << element #додавання цілого числа до стеку з фінальною фідповідю
end

def if_closing_parenthesis(result_stack, intermediate_stack)
    #якщо закриваюча дужка
    #перенесення всіх символів з list для проміжного записування математичних символів до стеку з фінальною фідповідю поки не попадеться відкриваюча дужка. 
    while intermediate_stack.last != '(' 
        result_stack << intermediate_stack.pop
    end
    intermediate_stack.pop
end

def operators(element, result_stack, intermediate_stack, prioritise)
    #якщо додавання, віднімання, множення, ділення та степінь
    # поки list для проміжного записування математичних символів не пустий 
    # та поки пріоритет переданого елементу менший або дорівнює останнього елементу в проміжному списку: перенесення елементу з проміжного списку до списку з фінальною відповідю
    while !intermediate_stack.empty? && prioritise[intermediate_stack.last] >= prioritise[element] 
        result_stack << intermediate_stack.pop 
    end
    #якщо хоча б одна умова не виконується, переданий елемент додається до списку для проміжного записування математичних символів
    intermediate_stack << element
end

puts("Enter an equation or enter 0 to exit: ")
equation = gets.chomp.gsub(/\s+/, "") #користувач вводить рівняння (або 0 для виходу з програми) і воно одразу ж очищуєтбся від пробілів

prioritise = {"+" => 1, "-"=> 1, "*"=> 2, "/"=> 2, "^"=> 3, "("=>0} #виставлення пріоритетів для дій

if equation != "0" #якщо користувач не ввін "0" для виходу
    equation_list = equation.chars #розділяємо рядок з рівнянням, шо ввів корситувач по елементах в list
    result_stack = Array.new #створення пустого list для фінальної відповіді
    intermediate_stack = Array.new #створення пустого list для проміжного записування математичних символів
    if equation_list.size < 3 #перевірка чи рівняння має хоча б три знаки 
        puts "Stack is too small for operator application"
        exit
    else
        equation_list.each do |element| # перебираємо всі елементи в list з рівнянням 
            begin #пробуємо перевести елемент в ціле число, якщо виходить, значить це просте число, записуємо його одразу до списку з фінальною відповідю
                element = Integer(element)
                if_integer(element, result_stack)
            rescue ArgumentError #якщо виникає помилка, тобто елемент не ціле число, значить це математичний символ
                if element == "(" #якщо математичний символ-відкриваєча дужка
                    intermediate_stack << element #додаємо відкриваючу дужку до проміжного стеку
                elsif prioritise.key?(element)  # Якщо математичний символ +, -, *, /, ^
                    operators(element, result_stack, intermediate_stack, prioritise)
                elsif element == ")" #якщо математичний символ-закриваєча дужка
                    if_closing_parenthesis(result_stack, intermediate_stack)
                else #якщо такого матиматичного символа програма не знає
                    puts("Sorry I don't know this token")
                end
            end
    end
    result_stack << intermediate_stack.reverse() #вивертаємо проміжний стек та додаємо його до стеку кінцевого результату
    result = result_stack.join(" ") #об'єднуємо стек кінцевого результату в рядок
    puts("Results: #{result}") #виводимо результати роботи програми
end
else #закінчення роботи програми, якщо користувач замість ввести рівняння ввів "0"
    puts("you have exited the program.") 
end

