require_relative "../lib/geocode_helper"

describe Geocode_helper do
  before :each do
    @GH = Geocode_helper.new
  end

  it "should say hello" do
    expect(@GH.say_hello).to eq "Hello there"
  end

  it "should get a street from a latitude and longitude" do
    res = @GH.get_street(51.437406, -0.036607)
    expect(res).to eq "Lutwyche Road"
  end
end
