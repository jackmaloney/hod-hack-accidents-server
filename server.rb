require 'sinatra'
require 'json'
require_relative "lib/geocode_helper"
require 'find'
require 'exifr'
require 'tilt/haml'

set :bind, '0.0.0.0'

before '/' do
end

get '/scan' do
  content_type :html
  dir = Dir.pwd + '/public/images'
  image_list = {}
  Find.find(dir) do |file|
    if file =~ /.jpg$/i
      begin
        shortname = file.split("/").last
        longitude = EXIFR::JPEG.new(file).gps.longitude
        latitude = EXIFR::JPEG.new(file).gps.latitude
        GH = Geocode_helper.new latitude, longitude
        image_list[file] = {:longitude => longitude, :latitude => latitude, :name => shortname, :info => GH.get_address_data.inspect}
      rescue
        puts "rescued"
      end
    end
    puts image_list.inspect
  end
  haml :show_pics, :locals => {:list => image_list}
end

get '/' do
  content_type :json
  data = {
    :status => "OK",
    :timestamp => Time.now.to_s
  }
  if params["latitude"] and params["longitude"]
    data[:latitude] = params["latitude"]
    data[:longitude] = params["longitude"]
    GH = Geocode_helper.new params["latitude"], params["longitude"]
    data[:address_data] = GH.get_address_data
  end
  data.to_json
end

post '/' do
  content_type :json
  data = {
    :status => "OK",
    :timestamp => Time.now.to_s
  }
  if params["latitude"] and params["longitude"]
    data[:latitude] = params["latitude"]
    data[:longitude] = params["longitude"]
    GH = Geocode_helper.new params["latitude"], params["longitude"]
    data[:address_data] = GH.get_address_data
  end
  data.to_json
end

