class MockBoard
  attr_accessor :spaces,
                :filled_space,
                :played_piece,
                :resets_board

  def spaces
    @spaces = [nil] * 9
  end

  def fill(move, piece)
    @filled_space = move
    @played_piece = piece
  end

  def reset
    @resets_board = true
  end
end