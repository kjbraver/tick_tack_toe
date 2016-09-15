require "./game_board.rb"

puts "Welcome to Tick Tack Toe"
# puts "Would you like to read the instructions?"
# print "Input: "
# userInput = gets.downcase
# print_instructions if userInput.eql?("yes")

puts "Choice Time! Would you like to be X's or O's?"
puts "Enter 'X' to select X's or 'O' to select O's."
print "Input: "
player_mark = gets.chomp
puts ""

until(player_mark.upcase.eql?("X") || player_mark.upcase.eql?("O"))
	puts "Error: Invalid input!"
	puts "Enter 'X' to select X's or 'O' to select O's."
	print "Input: "
	player_mark = gets.chomp
	puts ""
end

game_board = GameBoard(player_mark)



def game_menu
	puts "It's Your Turn!"
	puts "Enter 'move' to take your turn."
	puts "Enter 'surrender' to forfeit the game." 
	puts "Enter 'instructions' to read this game's instructions"
	print "Input: "
	userInput = gets

	# switch(userInput.downcase)
	# 	when "move" then #movescreen
	# 	when "surrender" then #youlose
	# 	when "instructions" then #print instructions
	# end
end