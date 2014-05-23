class MockSettings
  attr_accessor :checked_current_player_type,
                :current_player_piece,
                :triggered_next_player_mark,
                :triggered_next_player_type

  def current_player_piece
    @current_player_piece
  end

  def next_player_piece
    @triggered_next_player_mark = true
  end

  def next_player_type
    @triggered_next_player_type = true 
  end

  def current_player_type
    @checked_current_player_type = "AI"
  end
end