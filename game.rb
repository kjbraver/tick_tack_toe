require "./game_board.rb"

def print_instructions
  puts ""
  puts "Interested in learning how to play Tick Tack Toe?"
  sleep(1) 
  puts "Well you've come to the right place!"
  sleep(1)
  puts "The object of the game is simple: get three in a row!"
  sleep(1)
  puts "Column, row, or diagonal...it doesn't matter! Get three in a row and you win!"
  sleep(1)
  puts "You should know though...X always go first."
  sleep(1)
  puts "Ready to play? Press enter when you're ready to move on."
  gets
end

def player_turn(game_board)
  puts "It's Your Turn!"
  game_board.display_board
  puts "Enter 'move' to take your turn."
  puts "Enter 'surrender' to forfeit the game." 
  puts "Enter 'instructions' to read this game's instructions"
  print "Input: "
  userInput = gets.chomp.downcase
  puts ""

  validInput = ["move", "surrender", "instructions"]
  unless(validInput.include?(userInput))
    puts "Error: Invalid input! Please try again!"
    sleep(1)
    game_board.display_board
    puts "Enter 'move' to take your turn."
    puts "Enter 'surrender' to forfeit the game." 
    puts "Enter 'instructions' to read this game's instructions"
    print "Input: "
    userInput = gets.chomp.downcase
    puts ""
  end

  if(userInput.eql?("surrender")) 
      return :surrender
  else
    print_instructions if userInput.eql?("instructions")
      
    puts "Possible moves are: "
    game_board.display_open_squares
    puts "" 
    puts "Where would you like to move?"
    print "Location: "
    location = gets.chomp.to_sym
    error = game_board.record_player_move(location)

    while(error == -1)
      puts ""
      puts "Error: Invalid move location! Please try again!"
      sleep(1)
      puts "Possible moves are: "
      game_board.display_open_squares
      puts ""
      puts "Where would you like to move?"
      print "Location: "
      location = gets.chomp.to_sym
      error = game_board.record_player_move(location)
    end

    puts "Great move!"
    game_board.display_board
  end

  return nil
end

def ai_turn(game_board)
    puts "It's the computer's turn!"
    sleep(1)
    print "Thinking."
    sleep(1)
    print "."
    sleep(1)
    print "."
    sleep(1)
    print "."
    sleep(1)
    puts ""
    puts ""

    game_board.ai_move
end

puts "Welcome to Tick Tack Toe"
puts "Would you like to read the instructions?"
print "Input: "
userInput = gets.chomp.downcase
puts ""
print_instructions if userInput.eql?("yes") || userInput.eql?("y")

puts "Choice Time! Would you like to be X's or O's?"
puts "Enter 'X' to select X's or 'O' to select O's."
print "Input: "
player_mark = gets.chomp.upcase
puts ""

until(player_mark.upcase.eql?("X") || player_mark.upcase.eql?("O"))
  puts "Error: Invalid input!"
  puts "Enter 'X' to select X's or 'O' to select O's."
  print "Input: "
  player_mark = gets.chomp.upcase
  puts ""
end

game_board = GameBoard.new(player_mark)

winner = nil
until(winner)
  if(player_mark.eql?("X"))
    break if winner = player_turn(game_board)
    break if winner = game_board.game_over
    ai_turn(game_board)
  else
    ai_turn(game_board)
    break if winner = game_board.game_over
    break if winner = player_turn(game_board)
  end
  winner = game_board.game_over
end

puts "Game Over!"
game_board.display_board
case winner
  when :surrender then puts "You lose by forfeit. Sorry :("
  when :catsgame then puts "No one wins! Cat's Game"
  when :player then puts "You win!"
  when :ai then puts "The computer wins! Sorry :("
end


