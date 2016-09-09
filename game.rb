class GameBoard
	def initialize
    @move_log = {
      :top_left => 0,
      :top_middle => 0,
      :top_right => 0,
      :middle_left => 0,
      :middle_middle => 0,
      :middle_right => 0,
      :bottom_left => 0,
      :botton_middle => 0,
      :botton_right => 0}
	end

  public
  
  def recordPlayerMove(location, move)
    @move_log[location] = move
  end

	def displayBoard
    puts ""
    puts "  #{@move_log[:top_left]} | #{@move_log[:top_middle]} | #{@move_log[:top_right]} "
    puts "-------------"
    puts "  #{@move_log[:middle_left]} | #{@move_log[:middle_middle]} | #{@move_log[:middle_right]} "
    puts "-------------"
    puts "  #{@move_log[:bottom_left]} | #{@move_log[:botton_middle]} | #{@move_log[:botton_right]} "
    puts ""
	end
end

a = GameBoard.new
a.displayBoard
a.recordPlayerMove(:top_left, "X")
a.displayBoard