class Settings
  attr_accessor :current_player_mark, :current_player_type,
                :player_one_mark,     :player_one_type,
                :player_two_mark,     :player_two_type

  def initialize(params = {})
    @player_one_mark     = params[:player_one_mark]
    @player_two_mark     = params[:player_two_mark]
    @player_one_type      = params[:player_one_type]
    @player_two_type      = params[:player_two_type]
    @current_player_mark = params[:player_one_mark]
    @current_player_type  = params[:player_one_type]
  end

  def next_player_mark
    @current_player_mark == @player_one_mark ? @player_two_mark : @player_one_mark
  end

  def next_player_type
    @current_player_type  == @player_one_type ? @player_two_type : @player_one_type
  end
end