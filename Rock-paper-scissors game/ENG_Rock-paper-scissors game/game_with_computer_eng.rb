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

def computer_play
    ["rock", "scissors", "paper"].sample
end

def end_game(choice, user_name, points, num_game)
    if choice == "0"
        if num_game > 0
            puts("Game over")
            puts("Final score: \n ")
            puts(point_results(user_name, points))
            exit
        else
            puts("Game over")

            exit
        
        end
    end
end


def point_results(user_name, points)
    puts(" #{user_name}: #{points[:player]}\n Computer: #{points[:computer]}")
end


def determination_of_the_winner(normal_player_choise, computer_choise, points)
    winning_combinations = {
      "rock" => "scissors",
      "scissors" => "paper",
      "paper" => "rock"
    }
  
    if normal_player_choise == computer_choise
      puts("A draw!")
    elsif winning_combinations[normal_player_choise] == computer_choise
      puts("You won!")
      points[:player] += 1
    else
      puts("The computer won!")
      points[:computer] += 1
    end
end
  

num_game = 0

puts("Enter your name. Enter 0 to exit the game:")
player_name = gets.chomp

end_game(player_name, "", "", num_game)

points = {player: 0, computer: 0}

loop do
    puts("Choose 'rock', 'scissors' or 'paper'. Enter 0 to exit the game:")
    player_choise = gets.chomp.downcase
    
    end_game(player_choise, player_name, points, num_game)

    normal_player_choise = normalize_choice(player_choise)

    if  ["rock", "scissors", "paper"].include?(normal_player_choise)

        num_game+=1

        computer_choise = computer_play
        puts("Computer selection: #{computer_choise}")
        
        puts(determination_of_the_winner(normal_player_choise, computer_choise, points))
        
        puts("Score:\n")
        puts(point_results(player_name, points))
    else
        puts("Incorrect choice. Try again.")
    end
end
