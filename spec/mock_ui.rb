class MockUI
  attr_accessor :asked_player_for_move,
                :baord,
                :displayed_computer_message,
                :displayed_updated_board,
                :got_player_type,
                :got_mark_for,
                :invalid_message_sent,
                :moves,
                :provided_move,
                :showed_replay_message,
                :showed_tie_message,
                :showed_welcome_message,
                :showed_winner_message,
                :stored_moves

  def initialize
    @stored_moves = []
  end

  def welcome_user
    @showed_welcome_message = true
  end

  def gets_type_for(player_number)
    @got_player_type = true
  end

  def gets_mark_for(player_number)
    @got_mark_for = true
  end

  def display_grid(board)
    @displayed_updated_board = true
  end

  def ask_player_for_move(player_number)
    @asked_player_for_move = true
  end

  def invalid_move_message
    @invalid_message_sent = true
  end

  def gets_move
    @provided_move = true
    @stored_moves.shift
  end

  def winner_message(winner)
    @showed_winner_message = true
  end

  def tie_message
    @showed_tie_message = true
  end

  def game_over
    @showed_game_over_message = true
  end

  def ask_to_replay_game
    @showed_replay_message = true
  end
end