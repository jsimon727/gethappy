class LocationsController < ApplicationController
  before_action(:load_user)
  before_action(:load_location, { only: [:edit, :update, :destroy] })

def new
  @location = Location.new
end

def edit
end

def update
  @location.update(location_params)
  redirect_to user_path(@user)
end

def destroy
  @location.destroy
  redirect_to user_path(@user)
end


def index
  @user = User.find(params[:user_id])
  @user.latitude = 40.783776
  @user.longitude = -73.9
  @bars_custom = custom_bar_name(@user.latitude, @user.longitude)

end

def show
  @location = Location.find(params[:id])
  # if @location.bars.empty?

    @bars = get_bar_name(@location.zip_code || @location.neighborhood)
  #   @location.bars << @bars
  # else
  #   @bars = @location.bars
  # end
  # # @images = get_bar_image(@location.zip_code)

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

def get_bar_name(search_location)
  # location = @User.locations.address
  from_yelp = HTTParty.get("http://api.yelp.com/business_review_search?term=happy+hour&location=#{search_location}&ywsid=pciSmjmZPLGRzQTqu9mh8g")
  bar_name = from_yelp["businesses"]
  saved_bars = []
  select_bar_names = bar_name.each{ |bar| saved_bars << {"Name" => "#{bar["name"]}", "Location" => "#{bar["address1"]}", "Photo" => "#{bar["photo_url"]}", "url" => "#{bar["url"]}" } }
  saved_bars
end

def custom_bar_name(latitude, longitude)
  from_yelp = HTTParty.get("http://api.yelp.com/business_review_search?term=happy+hour&lat=#{latitude}&long=#{longitude}&radius=10&limit=5&ywsid=#{YELP_CLIENT_ID}")
  bar_name = from_yelp["businesses"]
  saved_bars = []
  select_bar_names = bar_name.each{ |bar| saved_bars << {"Name" => "#{bar["name"]}", "Location" => "#{bar["address1"]}", "Photo" => "#{bar["photo_url"]}", "url" => "#{bar["url"]}" } }
  saved_bars
end

  def load_user
    return @user = User.find(params[:user_id])
  end

  def load_location
    return @location = Location.find(params[:id])
  end

  def location_params
    params.require(:location).permit(:name, :neighborhood, :city, :state, :zip_code, :address)
  end

end