require 'game'

class WebGame
  attr_accessor :current_game, :player_one_piece, :player_two_piece

  def initialize(player_one_piece, player_two_piece)
    @player_one_piece = params[:player_one_piece]
    @player_two_piece = params[:player_two_piece]
  end

  def new_game
    @game = Game.new(@player_one_piece, @player_two_piece)
  end

  def current_game
    @game
  end
end