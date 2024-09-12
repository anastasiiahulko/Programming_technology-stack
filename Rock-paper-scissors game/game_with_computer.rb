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

def computer_play
    ["камінь", "ножиці", "папір"].sample
end

def end_game(choice, user_name, points)
    if choice == "0"
        if points.length<=0
            puts("Гру завершено")
            exit
        else
            puts("Гру завершено")
            puts("Кінцевий рахунок: \n ")
            puts(point_results(user_name, points))
            exit
        
        end
    end
end


def point_results(user_name, points)
    puts(" #{user_name}: #{points[:player]}\n Комп'ютер: #{points[:computer]}")
end


def determination_of_the_winner(normal_player_choise, computer_choise, points)
    
    if normal_player_choise == computer_choise
        puts("Нічия!")
    elsif (normal_player_choise == "камінь" && computer_choise == "ножиці") || 
        (normal_player_choise == "ножиці" &&  computer_choise == "папір") || 
        (normal_player_choise =="папір" && computer_choise == "камінь")
        puts("Ви виграли!")
        points[:player] +=1
        
    else
        puts("Комп'ютер виграв!")
        points[:computer] +=1
    end
end

puts("Введіть своє ім'я'. Для виходу з гри введіть 0:")
player_name = gets.chomp

end_game(player_name, "", "")

points = {player: 0, computer: 0}


loop do
    puts("Виберіть камінь, ножиці або папір. Для виходу з гри введіть 0:")
    player_choise = gets.chomp.downcase
    
    end_game(player_choise, player_name, points)
    
    normal_player_choise = normalize_choice(player_choise)

    if  ["камінь", "ножиці", "папір"].include?(normal_player_choise)
        computer_choise = computer_play
        puts("Вибір комп'ютера: #{computer_choise}")
        
        puts(determination_of_the_winner(normal_player_choise, computer_choise, points))
        
        puts("Рахунок:\n")
        puts(point_results(player_name, points))
    else
        puts("Некоректний вибір. Спробуйте ще раз.")
    end
end