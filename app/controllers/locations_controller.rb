class LocationsController < ApplicationController
  before_action(:load_user)
  before_action(:load_location, { only: [:edit, :update, :destroy] })

  def new
    @user = User.find(params[:user_id])
    @location = @user.locations.new
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
    @bars_geocode = get_bar_info_geocode(@user.latitude, @user.longitude)
  end

  def show
    @location = Location.find(params[:id])
    @bars = get_bar_info(@location.zip_code)
  end

  def create
    @user = User.find(params[:user_id])
    @location = @user.locations.create(location_params)
    redirect_to "/users/#{params[:user_id]}"
  end

private

  def get_bar_info(search_location)
    Rails.cache.fetch("/users/#{params[:user_id]}/locations/#{params[:id]}/deals", :expires_in => 12.hours) do
      happy_hour_data = HTTParty.get("http://api.yelp.com/business_review_search?term=happy+hour&location=#{search_location}&radius_filter=2500&limit=20&ywsid=#{YELP_CLIENT_ID}")
      bars = happy_hour_data["businesses"].map{ |bar| {"Name" => "#{bar["name"]}", "Location" => "#{bar["address1"]}", "Photo" => "#{bar["photo_url"]}", "url" => "#{bar["url"]}", "Review" => "#{bar["rating_img_url"]}", "Review_Count" => "#{bar["review_count"]}", "Deals" => "#{bar["deals"]}" } }
    end
  end

  def get_bar_info_geocode(latitude, longitude)
    Rails.cache.fetch("/users/#{params[:user_id]}/locations/#{params[:id]}/customdeals", :expires_in => 5.minutes) do
      happy_hour_data = HTTParty.get("http://api.yelp.com/business_review_search?term=happy+hour&lat=#{latitude}&long=#{longitude}&radius_filter=2500&limit=20&ywsid=#{YELP_CLIENT_ID}")
      bars = happy_hour_data["businesses"].map{ |bar| {"Name" => "#{bar["name"]}", "Location" => "#{bar["address1"]}", "Photo" => "#{bar["photo_url"]}", "url" => "#{bar["url"]}", "Review" => "#{bar["rating_img_url"]}", "Review_Count" => "#{bar["review_count"]}", "Deals" => "#{bar["deals"]}"  } }
    end
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