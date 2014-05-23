class MockBoard
  attr_accessor :filled_space,
                :played_piece,
                :resets_board,
                :spaces
  def spaces
    @spaces = true
  end

  def fill(move, piece)
    @filled_space = move
    @played_piece = piece
  end

  def reset
    @resets_board = true
  end
end