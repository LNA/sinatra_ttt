require 'game'
class WebGameStore
  @@games = []

  def self.games
    return @@games
  end

  def self.games
    @@games
  end

  def self.store(game)
    @@games << self
  end

  def self.new_game(params = {})
    @game = Game.new(params)
  end

  def self.current_game
    @game
  end

  def self.game_rules
    @game_rules = GameRules.new
  end

  def self.current_game_rules
    @game_rules
  end

  def self.board
    @board = Board.new 
  end

  def self.ai 
    @ai = AI.new
  end
end