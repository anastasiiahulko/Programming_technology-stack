def normalize_choice(choice)
    #нормалізуємо вибір користувачів. коли користувач вводить непоне або часткові слова rock, paper або scissors
    if ["rock", "roc", "ro", "r", "rok", "rokc", "rck"].include?(choice)
        "rock"
    elsif ["paper", "pape", "pap", "pa", "p", "papper", "paperr", "papre", "paperr", "papre"].include?(choice)
        "paper"
    elsif ["scissors", "scissor", "scisso", "sciss", "scis", "sci", "sci", "sc", "s", "scisor", "scissoors", "scissorz", "scissoes", "scissoz"].include?(choice)
        "scissors"
    else
        choice
    end
end

def computer_play
    #гернерація вибору комп'ютера
    ["rock", "scissors", "paper"].sample
end

def end_game(choice, player_name, points)
    #закінчення гри, якщо користувач ввів 0
    if choice == "0"
        if points.length != 0 #якщо раунди гри були та ігроки мають бали за гру
            puts("Game over")
            puts("Final score: \n ")
            puts(point_results(player_name, points))
            exit
        else #якщо ще не було жодного раунду та балів у ігнроків немає
            puts("Game over")
            exit
        end
    end
end


def point_results(player_name, points)
    #виведення результатів гри
    puts(" #{player_name}: #{points["player"]}\n Computer: #{points["computer"]}")
end


def determination_of_the_winner(normalized_pleyer_choise, computer_choise, points)
    #визначення переможців гри 
    winning_combinations = { #зазначення виграшних комбінацій
      "rock" => "scissors",
      "scissors" => "paper",
      "paper" => "rock"
    }
  
    if normalized_pleyer_choise == computer_choise #якщо вибір користувача та комп'ютера співпадать - нічия
      puts("A draw!")
    elsif winning_combinations[normalized_pleyer_choise] == computer_choise #якщо вибір користувача виграшний
        puts("You won!")
        if points.key?(:player)==false && points.key?(:computer)==false #якщо це перший раунд та гех балів порожній
            points["player"] = 1
            points["computer"] =0
        else #якщо це не перший раунд та є бали за гру, додаємо 1 бал користувачу
            points[:player] += 1
        end
    else #якщо вибір комп'ютера виграшни
        puts("The computer won!")
        if points.key?(:player)==false && points.key?(:computer)==false #якщо це перший раунд та гех балів порожній
            points["player"] = 0
            points["computer"] =1
        else #якщо це не перший раунд та є бали за гру, додаємо 1 бал компйютеру
            points[:computer] += 1
        end
    end
end

#тіло гри

#користувач вводить своє їм'я
puts("Enter your name. Enter 0 to exit the game:")
player_name = gets.chomp

#перевірка чи користувач ввів 0
end_game(player_name, "", "")

#створення пустого гешу для подальшого зберігання балів гравців
points = Hash.new

#цикл гри. 
loop do
    #користувач вводить rock, paper або scissors 
    puts("Choose 'rock', 'scissors' or 'paper'. Enter 0 to exit the game:")
    player_choise = gets.chomp.downcase
    
    #перевірка чи користувач ввів 0
    end_game(player_choise, player_name, points)

    #нормалізація вибору користувача, якщо він ввів, наприклад, не повне слово
    normalized_pleyer_choise = normalize_choice(player_choise )

    if  ["rock", "scissors", "paper"].include?(normalized_pleyer_choise) #преевірка яи користувач ввів саме rock, paper або scissors 
        computer_choise = computer_play #призначення вибора комп'ютера
        puts("Computer selection: #{computer_choise}") #виведення для користувача вибір комп'ютера
        puts(determination_of_the_winner(normalized_pleyer_choise, computer_choise, points)) #виклик функції визначення переможця раунда
        puts("Score:\n") #вивід поточного рахунку
        puts(point_results(player_name, points)) #виклик функції виведення рахунку гри
    else #вивід повідомлення про некоректний вибір, якщо користувач ввів щось окрім rock, paper або scissors  та кормалізувати його не вийшло
        puts("Incorrect choice. Try again.")
    end
end
