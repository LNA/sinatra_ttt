class Game
  attr_accessor :ai, 
                :board,
                :game_rules, 
                :settings

  def initialize(ai, board, game_rules, settings)
    @ai         = ai
    @board      = board
    @game_rules = game_rules
    @settings   = settings
  end
end
