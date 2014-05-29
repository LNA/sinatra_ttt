class MockSettings
  attr_accessor :checked_current_player_type,
                :current_player_piece,
                :current_player_type,
                :triggered_next_player_mark,
                :triggered_next_player_type,
                :next_player_type_value
  def initialize
    @current_player_type = 'AI'
  end

  def current_player_piece
    @current_player_piece
  end

  def next_player_piece
    @triggered_next_player_mark = true
  end

  def next_player_type
    @triggered_next_player_type = true
    @next_player_type_value 
  end

  def current_player_type
    @checked_current_player_type = "AI"
    @current_player_type
  end
end