require_relative '../app'
require 'spec_helper'

set :environment, :test

describe 'Trellhub' do

  before(:each) do
    json_fixture = File.open("spec/fixtures/push.json", "rb")
    @json = JSON.parse(json_fixture.read)
  end

  def app
    Sinatra::Application
  end

  it "receives a push" do
    post '/push', :payload => @json.to_json
    last_response.should be_ok
  end
end