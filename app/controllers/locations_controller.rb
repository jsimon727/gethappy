class LocationsController < ApplicationController

def new
  @location = Location.new
end

def show
  @location = Location.find(params[:id])
  @bars = get_bar_name(@location.zip_code)
end

def create
  @location = Location.new(location_params)
  @location.save
  redirect_to "/users/#{params[:user_id]}"
end

private

def get_bar_name(location)
  # location = @User.locations.address
  from_yelp = HTTParty.get("http://api.yelp.com/business_review_search?term=happy+hour&location=#{location}&ywsid=pciSmjmZPLGRzQTqu9mh8g")
  bar_name = from_yelp["businesses"]
  select_bar_names = bar_name.map{ |bar| bar["name"] }
end

  def location_params
    params.require(:location).permit(:name, :neighborhood, :city, :state, :zip_code, :address)
  end

end