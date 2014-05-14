require 'spec_helper'
describe Game do 
  let (:game) {Game.new}

  it 'changes to the next player from X to O' do
    game.player_one_piece       = 'X'
    game.player_two_piece       = 'O'
    game.current_player_piece   = 'X'

    game.next_player_piece.should == "O" 
  end

  it 'changes player type from human to ai' do 
    game.player_one_type       = 'Human'
    game.player_two_type       = 'AI'
    game.current_player_type   = 'Human'

    game.next_player_type.should == "AI" 
  end
end