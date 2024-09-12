def end_game(choice, name_of_first_user, name_of_second_user, points)
    if choice == "0"
        if points.length<=0
            puts("Гру завершено")
            exit
        else
            puts("Гру завершено")
            puts("Кінцевий рахунок: \n ")
            puts(point_results(name_of_first_user, name_of_second_user, points))
            exit
        
        end
    end
end

def normalize_choice(choice)
    case choice
    when /^к/
        "камінь"
    when /^н/
        "ножиці"
    when /^п/
        "папір"
    else
        choice
    end
end

def point_results(name_of_first_user, name_of_second_user, points)
    puts(" #{name_of_first_user}: #{points[:player_one]}\n #{name_of_second_user}: #{points[:player_two]}")
end

def determination_of_the_winner(notmal_first_user_choise, notmal_second_user_choise, name_of_first_user, name_of_second_user, points)
    
    if notmal_first_user_choise == notmal_second_user_choise
        puts("Нічия!")
    elsif (notmal_first_user_choise == "камінь" && notmal_second_user_choise == "ножиці") || 
        (notmal_first_user_choise == "ножиці" &&  notmal_second_user_choise == "папір") || 
        (notmal_first_user_choise =="папір" && notmal_second_user_choise == "камінь")
        puts("#{name_of_first_user} виграв(-ла)!")
        points[:player_one] +=1
        
    else
        puts("#{name_of_second_user} виграв(-ла)!")
        points[:player_two] +=1
    end
end

puts("Введіть свої імена. Для виходу з гри введіть 0.")
puts("Гравець 1:")
name_of_first_user = gets.chomp.downcase

end_game(name_of_first_user, "", "", "")

puts("Гравець 2:")
name_of_second_user = gets.chomp

end_game(name_of_second_user, "", "", "")

points = {player_one: 0, player_two: 0}

# Камінь ламає ножиці
# Ножиці ріжуть папір
# Папір накриває камінь

loop do
    puts("Гравець 1, виберіть камінь, ножиці або папір. Для виходу з гри введіть 0:")
    first_user_choise = gets.chomp
    
    end_game(first_user_choise, name_of_first_user, name_of_second_user, points)
    
    notmal_first_user_choise = normalize_choice(first_user_choise)

    puts("Гравець 2, виберіть камінь, ножиці або папір. Для виходу з гри введіть 0:")
    second_user_choise = gets.chomp
    
    end_game(second_user_choise, name_of_first_user, name_of_second_user, points)
    
    notmal_second_user_choise = normalize_choice(second_user_choise)

    if ["камінь", "ножиці", "папір"].include?(notmal_first_user_choise) && ["камінь", "ножиці", "папір"].include?(notmal_second_user_choise)
        puts(determination_of_the_winner(notmal_first_user_choise, notmal_second_user_choise, name_of_first_user, name_of_second_user, points))
        puts("Рахунок: \n")
        puts(point_results(name_of_first_user, name_of_second_user, points))
    else
        puts("Некоректний вибір. Спробуйте ще раз")
    end
end