require 'rubygems'
require 'bundler'

Bundler.require

RSpec.configure do |conf|
  conf.include Rack::Test::Methods
end