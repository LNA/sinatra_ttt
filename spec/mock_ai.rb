class MockAI
  attr_accessor :found_best_move

  def find_best_move(board, opponent_piece, game_piece)
    @found_best_move = true
  end
end