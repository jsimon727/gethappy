require 'httparty'

def get_bar_name(location)
  # location = @User.locations.address
  from_yelp = HTTParty.get("http://api.yelp.com/business_review_search?term=happy+hour&location=#{location}&ywsid=pciSmjmZPLGRzQTqu9mh8g")
  bar_name = from_yelp["businesses"]
  select_bar_names = bar_name.map{ |bar| bar["name"] }
end



def custom_bar_name(latitude, longitude)
  from_yelp = HTTParty.get("http://api.yelp.com/business_review_search?term=happy+hour&lat=#{latitude}&long=#{longitude}&radius=10&limit=5&ywsid=pciSmjmZPLGRzQTqu9mh8g")
  bar_name = from_yelp["businesses"]
  select_bar_names = bar_name.map{ |bar| bar["name"] }
end


