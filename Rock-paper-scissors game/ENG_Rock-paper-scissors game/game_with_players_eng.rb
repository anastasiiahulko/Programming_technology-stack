def end_game(choice, name_of_first_user, name_of_second_user, points)
    if choice == "0"
        if points.length<=0
            puts("Game over")
            exit
        else
            puts("Game over")
            puts("Final score: \n ")
            puts(point_results(name_of_first_user, name_of_second_user, points))
            exit
        
        end
    end
end

def normalize_choice(choice)
    if ["rock", "roc", "ro", "r"].include?(choice)
        "rock"
    elsif ["paper", "pape", "pap", "pa", "p"].include?(choice)
        "paper"
    elsif ["scissors", "scissor", "scisso", "sciss", "scis", "sci", "sci", "sc", "s"].include?(choice)
        "scissors"
    else
        choice
    end
end

def point_results(name_of_first_user, name_of_second_user, points)
    puts(" #{name_of_first_user}: #{points[:player_one]}\n #{name_of_second_user}: #{points[:player_two]}")
end

def determination_of_the_winner(normal_first_user_choise, normal_second_user_choise, name_of_first_user, name_of_second_user, points)
    winning_combinations = {
        "rock" => "scissors",
        "scissors" => "paper",
        "paper" => "rock"
      }

    if normal_first_user_choise == normal_second_user_choise
        puts("A draw!")
    elsif winning_combinations[normal_first_user_choise] == normal_second_user_choise
        puts("#{name_of_first_user} won!")
        points[:player_one] +=1
        
    else
        puts("#{name_of_second_user} won!")
        points[:player_two] +=1
    end
end

puts("Enter your names. Enter 0 to exit the game:")
puts("Player 1:")
name_of_first_user = gets.chomp

end_game(name_of_first_user, "", "", "")

puts("Player 2:")
name_of_second_user = gets.chomp

end_game(name_of_second_user, "", "", "")

points = {player_one: 0, player_two: 0}

# Камінь ламає ножиці
# Ножиці ріжуть папір
# Папір накриває камінь

loop do
    puts("Player #{name_of_first_user}, choose 'rock', 'scissors' or 'paper'. Enter 0 to exit the game:")
    first_user_choise = gets.chomp
    
    end_game(first_user_choise, name_of_first_user, name_of_second_user, points)
    
    normal_first_user_choise = normalize_choice(first_user_choise)

    puts("Player #{name_of_second_user}, choose 'rock', 'scissors' or 'paper'. Enter 0 to exit the game:")
    second_user_choise = gets.chomp
    
    end_game(second_user_choise, name_of_first_user, name_of_second_user, points)
    
    normal_second_user_choise = normalize_choice(second_user_choise)

    if ["rock", "scissors", "paper"].include?(normal_first_user_choise) && ["rock", "scissors", "paper"].include?(normal_second_user_choise)
        puts(determination_of_the_winner(normal_first_user_choise, normal_second_user_choise, name_of_first_user, name_of_second_user, points))
        puts("Score: \n")
        puts(point_results(name_of_first_user, name_of_second_user, points))
    else
        puts("Incorrect choice. Try again.")
    end
end
