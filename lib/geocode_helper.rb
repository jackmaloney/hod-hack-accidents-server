require 'geocoder/cli'

class Geocode_helper
  def initialize
    @geo = Geocoder
    @geo.configure({:lookup=>:google, :sensor => false})
  end

  def say_hello
    "Hello there"
  end

  def get_street lat, long
    res = @geo.search lat.to_s + "," + long.to_s
    self.get_street_from_res res
  end

  def get_street_from_res res
    res.first.data["address_components"].each do |d|
      case d["types"]
        when ["route"]
          return d["long_name"]
        else
          #puts "nothing to see here"
      end
      "found nothing"
    end
  end
end
