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
    create_game 
    create_game_rules 
    create_board
    create_current_player
    create_ai

    redirect to('/play')
  end

  get '/play' do
    render_board
    
    erb '/board'.to_sym
  end

  post '/move' do
    make_move
    check_for_winner
    next_player
    next_player_type
    render_board

    erb '/board'.to_sym
  end

  get '/winner' do
    erb '/game_over'.to_sym
  end

  get '/play_again' do
    session.clear
    erb '/welcome'.to_sym

    redirect '/'
  end

private
  def make_move
    make_human_move if session[:game].current_player_type == "Human"
    make_ai_move    if session[:game].current_player_type == "AI"
  end

  def make_human_move
    move = fetch_square
    session[:board].fill(move.to_i, session[:game].current_player_piece)
  end

  def make_ai_move
    session[:board].fill(session[:ai].find_best_move(session[:board], session[:game].current_player_piece, session[:game].next_player_piece), session[:game].current_player_piece)
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

  def create_ai
    session[:ai] = WebGameStore.ai
  end

  def render_board
    @board = session[:board].spaces
  end

  def fetch_square
    params.fetch("square")
  end

  def check_for_winner
    redirect '/winner' if session[:game_rules].game_over?(session[:board].spaces)
  end

  def next_player
    session[:game].current_player_piece = session[:game].next_player_piece
  end

  def next_player_type
    session[:game].current_player_type = session[:game].next_player_type
  end
end