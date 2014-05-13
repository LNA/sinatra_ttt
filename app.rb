$: << File.expand_path(File.dirname(__FILE__)) + '/lib'
Dir[File.dirname(__FILE__) + '/lib/models/*.rb'].each {|file| require file }

require 'sinatra'
require 'ai'
require 'board'
require 'game_rules'
require 'game'
# require 'repository'
require 'web_game'
require 'web_game_store'

# Repository.register(:game, WebGameStore)

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

    redirect to('/play')
  end

  get '/play' do
    @board = session[:board].spaces
    erb '/board'.to_sym
  end

  post '/move' do
    move = params.fetch("square")
    make(move)
    check_for_winner
    session[:game].current_player = session[:game].next_player
    @board = session[:board].spaces

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

  def make(move)
    session[:board].fill(move.to_i, session[:game].current_player)
  end

  def check_for_winner
    if session[:game_rules].game_over?(session[:board].spaces)
      redirect '/winner'
    end
  end
end