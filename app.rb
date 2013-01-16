require 'sinatra'

Dir["#{File.dirname(__FILE__)}/lib/**/*.rb"].each { |library| load library }

post '/push' do
  Trellhub.new(params[:payload]).receive_push
end