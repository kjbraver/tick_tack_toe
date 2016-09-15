class GameBoard
  
  def initialize(player_mark="X")
    @player_mark = player_mark
    @player_mark = "O" unless @player_mark.eql?("X")
    player_mark.eql?("X") ? @ai_mark = "O" : @ai_mark = "X"

    @game_over = false

    @move_log = {
      :top_left => " ",
      :top_middle => " ",
      :top_right => " ",
      :middle_left => " ",
      :middle_middle => " ",
      :middle_right => " ",
      :bottom_left => " ",
      :bottom_middle => " ",
      :bottom_right => " "} 

    @win_lanes = {
      :top_row => [:top_left, :top_middle, :top_right],
      :middle_row => [:middle_left, :middle_middle, :middle_right],
      :bottom_row => [:bottom_left, :bottom_middle, :bottom_right],
      :left_column => [:top_left, :middle_left, :bottom_left],
      :middle_column => [:top_middle, :middle_middle, :bottom_middle],
      :right_column => [:top_right, :middle_right, :bottom_right],
      :left_diagonal => [:top_left, :middle_middle, :bottom_right],
      :right_diagonal => [:top_right, :middle_middle, :bottom_left]}

    @board_state = {
      :top_row => :neutral,
      :middle_row => :neutral,
      :bottom_row => :neutral,
      :left_column => :neutral,
      :middle_column => :neutral,
      :right_column => :neutral,
      :left_diagonal => :neutral,
      :right_diagonal => :neutral}

    @open_squares = @move_log.keys
  end

  private

  #updates @board_state to reflect current conditions of board
  def analyze_board
    @win_lanes.each do |key, win_lane|
      ai_count = 0
      player_count = 0

      win_lane.each do |square|
        ai_count += 1 if @move_log[square].eql?(@ai_mark)
        player_count += 1 if @move_log[square].eql?(@player_mark)
      end

      if(player_count + ai_count == 3)
        if(player_count == 3)
          @board_state[key] = :win_player
        elsif(ai_count == 3)
          @board_state[key] = :win_ai
        else
          @board_state[key] = :locked
        end
      elsif(player_count == 2)
        @board_state[key] = :lean_player
      elsif(ai_count == 2)
        @board_state[key] = :lean_ai
      else
        @board_state[key] = :neutral
      end
    end
  end

  #if game can be won on next turn, return that the location of that square immediately
  #else return the location of a square where there is threat of loss
  #if no threat of loss return random empty square
  def prioritize_moveset
    analyze_board
    priority_move = nil

    @board_state.each do |location, state|
      return next_empty_square(location) if state.eql?(:lean_ai)
      priority_move = location if state.eql?(:lean_player)
    end
    
    if priority_move.nil?
      return @open_squares.sample
    else
      return next_empty_square(priority_move)
    end
  end

  #given a win_lane, this method will find its first empty square (i.e. " ")
  def next_empty_square(win_lane)
    @win_lanes[win_lane].each do |square|
      return square if @move_log[square].eql?(" ")
    end
  end

  #updates the board to reflect a given move
  def update_game_board(location, move)
    @open_squares.delete(location)
    @move_log[location] = move
  end

  def game_results
    analyze_board
    return :catsgame if @open_squares.empty?
    @board_state.each do |location, state|
      return :player if state.eql?(:win_player) 
      return :ai if state.eql?(:win_ai)
    end
    return nil
  end

  public
  
  def record_player_move(location)
    return -1 if !@open_squares.include?(location)
    
    update_game_board(location, @player_mark)
    return 0
  end

  # #prints a summary of @game_state to screen
  # def display_board_state
  #   analyze_board
  #   @board_state.each {|key, value| puts "#{key}: #{value}"}
  # end

  #prints game board to screen
  def display_board
    puts ""
    puts "  #{@move_log[:top_left]} | #{@move_log[:top_middle]} | #{@move_log[:top_right]} "
    puts "-------------"
    puts "  #{@move_log[:middle_left]} | #{@move_log[:middle_middle]} | #{@move_log[:middle_right]} "
    puts "-------------"
    puts "  #{@move_log[:bottom_left]} | #{@move_log[:bottom_middle]} | #{@move_log[:bottom_right]} "
    puts ""
    return 0
  end

  #displays still avaliable moves
  def display_open_squares
    @open_squares.each {|square| print "#{square} "}
    return 0
  end

  def game_over
    return game_results
  end

  #ai takes its turn when this method is called
  def ai_move
    update_game_board(prioritize_moveset, @ai_mark)
    return 0
  end
end