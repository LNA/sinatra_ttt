require 'spec_helper'

describe App do
  let (:app)   {App.new}

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
      session = {}
      post '/new_game', {'rack.session' =>  { 'foo' => 'blah' } }
    end
  end

  context '#post_move' do
    #let(:valid_move_params) { "square" => "1" }

    it 'updates the board with move passed in' do
      board = Board.new
      {'rack.session' => {}}
      post '/move', { "square" => "1" }
      board.spaces[1].should == "X"
    end

    xit 'checks for winner after a move is placed' do
    end

    xit 'advances the next player' do
    end

    xit 'advances the next player type' do
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
    it 'renders the board with move buttons disabled after human move' do
      post '/move', 'rack.session' => {:square => 1,
                                       :game => {:next_player_type => "Human"}}

      expect(last_response.body).to_not include("submit")
    end

    xit 'renders the board with move buttons disbaled after AI move' do

    end
  end
end
