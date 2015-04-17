require 'sinatra'
require 'json'
require_relative "lib/geocode_helper"

set :bind, '0.0.0.0'

before '/' do
  content_type :json
end

get '/' do
  data = {
    :status => "OK",
    :data => "Thank you for getting at " + Time.now.to_s
  }
  data.to_json
end

post '/' do
  data = {
    :status => "OK",
    :data => "Thank you for posting at " + Time.now.to_s
  }
  if params["latitude"] and params["longitude"]
    GH = Geocode_helper.new params["latitude"], params["longitude"]
    data[:address_data] = GH.get_address_data
  end
  data.to_json
end

