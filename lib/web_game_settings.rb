require 'settings'

class WebGameSettings
  attr_accessor :current_settings, :player_one_piece,
                :player_two_piece

  def initialize(player_one_piece, player_two_piece)
    @player_one_piece = params[:player_one_piece]
    @player_two_piece = params[:player_two_piece]
  end

  def new_settings
    @setings = Settings.new(@player_one_piece, @player_two_piece)
  end

  def current_settings
    @settings
  end
end
