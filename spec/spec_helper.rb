$: << File.expand_path(File.dirname(__FILE__)) + '/../'
$: << File.expand_path(File.dirname(__FILE__)) + '/../lib/'

require 'app'
require 'rack/test'
require 'web_game_store'
require 'mock_ai'
require 'mock_board'
require 'mock_game_rules'
require 'mock_settings'
require 'mock_ui'

require 'pry'

def app
  App
end

RSpec.configure do |config|
  config.include Rack::Test::Methods
end