require 'spec_helper'

describe App do 
  let (:app) {App.new}

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
end