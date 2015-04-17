require 'geocoder/cli'

class Geocode_helper
  def initialize lat, long
    @geo = Geocoder
    @geo.configure({:lookup=>:google, :sensor => false})
    res = @geo.search lat.to_s + "," + long.to_s
    self.get_address_from_res res
  end

  def say_hello
    "Hello there"
  end

  def get_address_data
    @simple_map
  end

  def get_street 
    @simple_map[:street]
  end

  def get_address_from_res res
    #puts res.first.data["address_components"]
    @simple_map = {
      :number => nil,
      :street => nil,
      :post_code => nil
    }
    res.first.data["address_components"].each do |d|
      case d["types"]
        when ["street_number"]
          @simple_map[:number] = d["long_name"]
        when ["route"]
          @simple_map[:street] = d["long_name"]
        when ["postal_code"]
          @simple_map[:post_code] = d["long_name"]
        else
          #puts "nothing to see here"
      end
      "found nothing"
    end
  end
end
