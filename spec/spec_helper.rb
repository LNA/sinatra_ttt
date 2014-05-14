$: << File.expand_path(File.dirname(__FILE__)) + '/../'
$: << File.expand_path(File.dirname(__FILE__)) + '/../lib/'

require 'rack/test'
require 'app'

def app
  Sinatra::Application
end

RSpec.configure do |config|
  config.include Rack::Test::Methods
end