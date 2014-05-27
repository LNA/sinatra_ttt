require 'mock_board'
class MockGameRules
  attr_accessor :checked_for_full_board, :checked_for_game_over,
                :checked_for_winner,     :checked_validity_of_move,
                :game_over_values
  def initialize
    @game_over_values = []
  end

  def valid?(move, mock_board)
    @checked_validity_of_move = true
  end

  def full?(mock_board)
    @checked_for_full_board = true
  end

  def game_over?(mock_board)
    @checked_for_game_over = false
    # @game_over_values.shift || true
  end

  def winner(mock_board)
    @checked_for_winner = true
  end
end