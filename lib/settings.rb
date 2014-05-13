class Settings
  attr_accessor :current_player, :next_player,
                :player_one, :player_two,
                :player_one_piece, :player_two_piece,
                :player_one_type, :player_two_type

  def initialize(settings = {})
    require "pry"
    binding.pry
    @player_one_piece = settings[:player_one_piece]
    @player_two_piece = settings[:player_two_piece]
    @player_one_type  = settings[:player_one_type]
    @player_two_type  = settings[:player_two_type]
    @current_player   = @player_one_piece
  end

  def update(settings ={})
    @player_one_piece = settings[:player_one_piece] unless settings[:player_one_piece].nil?
    @player_two_piece = settings[:player_two_piece] unless settings[:player_two_piece].nil?
  end   

  def next_player
    @current_player == @player_one_piece ? @player_two_piece : @player_one_piece
  end
end