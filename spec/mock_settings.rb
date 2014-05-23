class MockSettings
  attr_accessor :current_player_piece,
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
end