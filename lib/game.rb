class Game
  # injuect board, game_rules and anything else I call session on here.
  # #use session[:game].ai
  # session[:game].board.fill() etc
  attr_accessor :current_player_piece, :current_player_type,
                :next_player,
                :player_one, :player_two,
                :player_one_piece, :player_two_piece,
                :player_one_type, :player_two_type

  def initialize(params = {})
    @player_one_piece     = params[:player_one_piece]
    @player_two_piece     = params[:player_two_piece]
    @player_one_type      = params[:player_one_type]
    @player_two_type      = params[:player_two_type]
    @current_player_piece = @player_one_piece
    @current_player_type  = @player_one_type
  end

  def next_player_piece
    @current_player_piece == @player_one_piece ? @player_two_piece : @player_one_piece
  end

  def next_player_type
    @current_player_type  == @player_one_type ? @player_two_type : @player_one_type
  end
end
