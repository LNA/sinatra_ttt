class Game
  attr_accessor :current_player, :next_player, 
                :player_one, :player_two,
                :player_one_piece, :player_two_piece,
                :player_one_type, :player_two_type

  def initialize(params = {})
    @player_one_piece = params[:player_one_piece]
    @player_two_piece = params[:player_two_piece]
    @player_one_type = params[:player_one_type]
    @player_two_type = params[:player_two_type]
    @current_player = @player_one_piece
  end

  def next_player
    @current_player == @player_one_piece ? @player_two_piece : @player_one_piece
  end
end