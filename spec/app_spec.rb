require 'spec_helper'

describe App do
  let (:mock_ai)         { MockAI.new}
  let (:mock_board)      { MockBoard.new }
  let (:mock_game_rules) { MockGameRules.new }
  let (:mock_settings)   { MockSettings.new  }

  before :each do 
    @mock_game = Game.new(mock_ai, mock_board, mock_game_rules, mock_settings)
    App.any_instance.should_receive(:game)
        .any_number_of_times.and_return(@mock_game)
    @mock_game.settings.current_player_piece = 'X'
    post '/move', params = {"square" => "1"}
  end

  context 'the home page' do
    it 'loads the home page' do
      get '/'

      last_response.should be_ok
    end

    it "displays the content of the hompage" do
      get '/'

      expect(last_response.body).to include("Start")
    end
  end

  context 'new game' do
    it 'creates a new game' do
      post '/new_game', {'rack.session' =>  { 'foo' => 'blah' } }
    end
  end

  context '#post_move' do
    it 'updates the board with move passed in' do
      @mock_game.board.filled_space.should == 1 
      @mock_game.board.played_piece.should == 'X'
    end

    it 'checks for winner after a move is placed' do
      @mock_game.game_rules.checked_for_game_over.should == "it got here"
    end

    it 'advances the next players game piece' do
      @mock_game.settings.triggered_next_player_mark.should == true
    end

    it 'advances the next player type' do
      @mock_game.settings.triggered_next_player_type.should == true
    end
  end

  context '#ai_move' do
    it 'retrieves best move from the AI' do

    end

    xit 'updates the board with move passed in' do
    end

    xit 'checks for winner after a move is placed' do
    end

    xit 'advances the next player' do
    end

    xit 'advances the next player type' do
    end
  end

  context 'next player is human' do
    it 'renders the board with move buttons enabled after human move' do
      post '/move', 'rack.session' => {:square => 1,
                                       :game => {:next_player_type => "Human"}}
      expect(last_response.body).to include("submit")
    end

    xit 'renders the board with move buttons enabled after ai move' do

    end
  end

  context 'next player is AI' do
    xit 'renders the board with move buttons disabled after human move' do
      post '/move', 'rack.session' => {:square => 1,
                                       :game => {:next_player_type => "Human"}}

      expect(last_response.body).to_not include("submit")
    end

    xit 'renders the board with move buttons disbaled after AI move' do

    end
  end
end
