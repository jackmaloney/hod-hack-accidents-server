require 'sinatra'
require 'json'
require_relative "lib/geocode_helper"

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
    GH = Geocode_helper.new
    data[:street] = GH.get_street params["latitude"], params["longitude"]
  end
  data.to_json
end

