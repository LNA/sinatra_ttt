$: << File.expand_path(File.dirname(__FILE__)) + '/lib'
Dir[File.dirname(__FILE__) + '/lib/models/*.rb'].each {|file| require file }

require 'sinatra'
require 'ai'
require 'board'
require 'game_rules'
require 'game'
require 'web_game_settings'
require 'web_game_store'

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
    redirect to('/play')
  end

  get '/play' do
    set_board
    redirect to ('/ai_move') if current_player_type == "AI"
    erb '/board'.to_sym 
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
    session.clear
    erb '/welcome'.to_sym

    redirect '/'
  end

# private
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
    redirect to ('/play') if current_player_type == "Human"
    erb '/auto_refresh_board'.to_sym
  end

  def process_redirect
    redirect to ('/ai_move') if current_player_type == "AI"
    erb '/auto_refresh_board'.to_sym if next_player_type == "AI"
    erb '/board'.to_sym if next_player_type == "Human"
  end

  def game
    session[:game]
  end

  def create_game
    session[:game] = Game.new(WebGameStore.ai,         WebGameStore.board,
                              WebGameStore.game_rules, WebGameStore.settings(params))
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
    best_move = game.ai.find_best_move(game.board, game.settings.current_player_piece, game.settings.next_player_piece)
    game.board.fill(best_move, game.settings.current_player_piece)
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
    game.settings.current_player_piece = game.settings.next_player_piece
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
    game.board.fill(fetch_square.to_i, game.settings.current_player_piece)
  end

  def fetch_square
    params.fetch("square")
  end

  def check_for_winner
    redirect '/winner' if game.game_rules.game_over?(game.board.spaces)
  end
end