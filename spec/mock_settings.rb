class MockSettings
  attr_accessor :current_player_piece,
                :triggered_next_player

  def current_player_piece
    @current_player_piece
  end

  def next_player_piece
    @triggered_next_player = true
  end
end