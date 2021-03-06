$: << File.expand_path(File.dirname(__FILE__)) + '/lib'
Dir[File.dirname(__FILE__) + '/lib/models/*.rb'].each {|file| require file }

require 'sinatra'
require 'ai'
require 'board'
require 'game_rules'
require 'game'
require 'web_game_settings'
require 'web_game_store'
require 'pry'

configure do
  enable :sessions
  set :session_secret, "My session secret"
end

class App < Sinatra::Application

  get '/' do
    erb '/welcome'.to_sym
  end

  post '/' do
    erb '/board'.to_sym
  end

  post '/new_game' do
    create_game
  end

  get '/play' do
    process_board_for_new_game 
  end

  post '/move' do
    process_human_move
  end

  get '/ai_move' do
    process_ai_move 
  end

  get '/winner' do
    erb '/game_over'.to_sym
  end

  get '/play_again' do
    process_replay
  end

# private
  def create_game
    session[:game] = Game.new(WebGameStore.ai,         WebGameStore.board,
                              WebGameStore.game_rules, WebGameStore.settings(params))
    redirect to('/play')
  end

  def process_board_for_new_game
    set_board
    if current_player_type == "AI"
      redirect to ('/ai_move') 
    end
    erb '/board'.to_sym 
  end

  def process_human_move
    set_board
    make_human_move
    progress_game
    process_redirect
    erb '/board'.to_sym
  end

  def process_ai_move
    set_board
    ai_turn
    next_board_after_ai_move
  end

  def process_redirect
    redirect to ('/ai_move') if current_player_type == "AI"
    erb '/auto_refresh_board'.to_sym if current_player_type == "AI"
    erb '/board'.to_sym if next_player_type == "Human"
  end

  def process_replay
    session.clear
    erb '/welcome'.to_sym
    redirect '/'
  end

  def next_board_after_ai_move
    if current_player_type == "Human"
      redirect to ('/play') 
    else
      render_auto_refresh_board      
    end
  end

  def render_auto_refresh_board
    erb '/auto_refresh_board'.to_sym
  end

  def game
    session[:game]
  end

  def ai_loop
    until game.game_rules.game_over?(session[:board].spaces)
      ai_turn
      set_board
    end
  end

  def neither_players_are_human?
    game.settings.player_one_type == "AI" && game.settings.player_two_type == "AI"
  end

  def ai_turn
    make_ai_move  if current_player_type == "AI"
    progress_game if current_player_type == "AI"
  end

  def make_ai_move
    best_move = game.ai.find_best_move(game.board.spaces, game.settings.current_player_mark, game.settings.next_player_mark)
    game.board.spaces[best_move] = game.settings.current_player_mark
  end

  def either_player_is_the_ai?
    game.settings.player_one_type == "AI" || game.settings.player_two_type == "AI"
  end

  def progress_game
    check_for_winner
    next_player
    next_player_type
  end

  def next_player
    game.settings.current_player_mark = game.settings.next_player_mark
  end

  def next_player_type
    game.settings.current_player_type = game.settings.next_player_type
  end

  def current_player_type
    game.settings.current_player_type
  end

  def set_board
    @board = game.board.spaces
  end

  def make_human_move
    game.board.spaces[fetch_square.to_i] = game.settings.current_player_mark
  end

  def fetch_square
    params.fetch("square")
  end

  def check_for_winner
    redirect '/winner' if game.game_rules.game_over?(game.board.spaces)
  end
end