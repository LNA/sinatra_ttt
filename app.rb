$: << File.expand_path(File.dirname(__FILE__)) + '/lib'
Dir[File.dirname(__FILE__) + '/lib/models/*.rb'].each {|file| require file }

require 'sinatra'
require 'ai'
require 'board'
require 'game_rules'
require 'game'
require 'web_game'
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
    create_game # Game interactor class GameInteractor.setup_new_game
    create_game_rules
    create_board
    create_current_player
    create_ai_if_needed

    redirect to('/play')
  end

  get '/test_board.js' do
    erb '/test_board.js'.to_sym
  end

  get '/play' do
    ai_loop if neither_players_are_human? # need to see board
    ai_turn if either_player_is_the_ai?
    render_board
    erb '/board'.to_sym
  end

  post '/move' do #web game interactor
    make_human_move
    progress_game
    #ai_turn
    render_board

    #if next_player is human
    erb '/board'.to_sym
    #if next player is ai
    #erb 'auto_refresh_board'.to_sym
  end

  get '/ai_move' do
    #...some stuff that needs to get done
    #
    #if next_player is human
    erb '/board'.to_sym
    #if next player is ai
    #erb 'auto_refresh_board'.to_sym
  end

  get '/winner' do
    erb '/game_over'.to_sym
  end

  get '/play_again' do
    session.clear
    erb '/welcome'.to_sym

    redirect '/'
  end

  def create_game
    session[:game] = WebGameStore.new_game(params)
  end

  def create_game_rules
    session[:game_rules] = WebGameStore.game_rules
  end

  def create_board
    session[:board] = WebGameStore.board
  end

  def create_current_player
    session[:game_rules].current_player = session[:game].player_one_piece
  end

  def create_ai_if_needed
    session[:ai] = WebGameStore.ai if either_player_is_the_ai?
  end

  def ai_loop
    until session[:game_rules].game_over?(session[:board].spaces)
      ai_turn
      render_board
    end
  end

  def neither_players_are_human?
    session[:game].player_one_type == "AI" && session[:game].player_two_type == "AI"
  end

  def ai_turn
    make_ai_move  if session[:game].current_player_type == "AI"
    progress_game if session[:game].current_player_type == "AI"
  end

  def make_ai_move
    best_move = session[:ai].find_best_move(session[:board], session[:game].current_player_piece, session[:game].next_player_piece)
    session[:board].fill(best_move, session[:game].current_player_piece)
  end

  def either_player_is_the_ai?
    session[:game].player_one_type == "AI" || session[:game].player_two_type == "AI"
  end

  def progress_game
    check_for_winner
    next_player
    next_player_type
  end

  def next_player
    session[:game].current_player_piece = session[:game].next_player_piece
  end

  def next_player_type
    session[:game].current_player_type = session[:game].next_player_type
  end

  def render_board
    @board = session[:board].spaces
  end

  def make_human_move
    session[:board].fill(fetch_square.to_i, session[:game].current_player_piece)
  end

  def fetch_square
    params.fetch("square")
  end

  def check_for_winner
    redirect '/winner' if session[:game_rules].game_over?(session[:board].spaces)
  end
end
