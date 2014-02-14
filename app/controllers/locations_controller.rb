class LocationsController < ApplicationController

def new
  @location = Location.new
end

def index
  @user = User.find(params[:user_id])
  @bars_custom = custom_bar_name(@user.latitude, @user.longitude)
end

def show
  @location = Location.find(params[:id])
  @bars = get_bar_name(@location.zip_code)

  # @custom_location = get_bar_name(params[:custom_location])
  # @bars = get_bar_name(@location.neighborhood unless neighborhood.nil? )
  # @bars = get_bar_name(@location.state unless state.nil? )
  # @bars = get_bar_name(@location.address unless address.nil? )
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

def custom_bar_name(latitude, longitude)
  from_yelp = HTTParty.get("http://api.yelp.com/business_review_search?term=happy+hour&lat=#{latitude}&long=#{longitude}&radius=10&limit=5&ywsid=pciSmjmZPLGRzQTqu9mh8g")

end

  def location_params
    params.require(:location).permit(:name, :neighborhood, :city, :state, :zip_code, :address)
  end

end