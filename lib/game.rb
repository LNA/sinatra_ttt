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

  def update(params ={})
    @player_one_piece = params[:player_one_piece] unless params[:player_one_piece].nil?
    @player_two_piece = params[:player_two_piece] unless params[:player_two_piece].nil?
  end         

  def either_player_is_ai(player_one, player_two)
    player_one == 'ai' || player_two == 'ai'
  end

  def next_player
    @current_player == @player_one_piece ? @player_two_piece : @player_one_piece
  end
end