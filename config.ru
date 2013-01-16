require 'rubygems'
require 'bundler'

Bundler.require

require './trellhub'
run Sinatra::Application
