class GameBoard
  
  def initialize
    @move_log = {
      :top_left => " ",
      :top_middle => " ",
      :top_right => " ",
      :middle_left => " ",
      :middle_middle => " ",
      :middle_right => " ",
      :bottom_left => " ",
      :botton_middle => " ",
      :botton_right => " "}
  end

  def updateGameBoard(location, move)
    @move_log[location] = move
  end

  public
  
  def recordPlayerMove(location, move)
    return false if(!@move_log.keys.include?(location) || !move.match(/[XxOo]/))
    
    updateGameBoard(location, move)
    return true
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
p a.recordPlayerMove(:top_left, "X")
p a.recordPlayerMove("blue", "X")
p a.recordPlayerMove(:top_left, "blue")
a.displayBoard