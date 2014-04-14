class BarsController < ApplicationController
  before_action :load_user, only: [:index, :favorite, :unfavorite, :destroy]

  def index
    @user.latitude = location.latitude
    @user.longitude = location.longitude
    @favorite_bar = @user.bars.find_by(params[:favorite_bar_id])
    @bars_geocode = get_bar_info_geocode(@user.latitude, @user.longitude)
  end

  def new
  
  end

  def show
    load_user
    @bar = Bar.find_by(name: params[:favorite_bars])
    @favorite_bars = @user.bars.map(&:name)
    # @photos = get_bar_images(@bar.name, @user.latitude, @user.longitude)
    # @favorite_bar = @user.bars.find_by(name: params[:favorite_bars])
    # @favorite_bar = Bar.find(params[:id])
  end

  def create
    load_user
    @bars = Bar.all
    @bar = Bar.new(bar_params)
    if @bars.map(&:address).include?(@bar.address)
      unless @user.bars.map(&:address).include?(@bar.address)
       @user.bars << @bar 
      end
    else
      @bar.save
      @user.bars << @bar
    end
    redirect_to user_bars_path(@user)
  end

  # def favorite
  #   load_user
  #   @user.bars << @bar
  # end

  def unfavorite
    @user_id = current_user.id
    currentuser.bars.delete(@bar)
  end

  def destroy
    @bar = Bar.find(params[:id])
    @bar.destroy
    redirect_to :back
  end
  

  private

  def get_bar_info_geocode(latitude, longitude)
    Rails.cache.fetch("/users/#{params[:user_id]}/locations/#{params[:id]}/customdeals", :expires_in => 5.minutes) do
      happy_hour_data = HTTParty.get("http://api.yelp.com/business_review_search?term=happy+hour&lat=#{latitude}&long=#{longitude}&radius_filter=2500&limit=20&ywsid=#{YELP_CLIENT_ID}")
      bars = happy_hour_data["businesses"].map{ |bar| {"Name" => "#{bar["name"]}", "Location" => "#{bar["address1"]}", "Photo" => "#{bar["photo_url"]}", "url" => "#{bar["url"]}", "Review" => "#{bar["rating_img_url"]}", "Review_Count" => "#{bar["review_count"]}", "Deals" => "#{bar["deals"]}"  } }
    end
  end

  # def in_db
  #   binding.pry
  #   @bars = Bar.all
  #   @bars.include?(@bar.address)
  # end

  # def current_bar

  # end

  # def get_bar_images(name, latitude, longitude)
  #   venue_data = HTTParty.get("https://api.foursquare.com/v2/venues/search?ll=#{latitude},#{longitude}&client_id=#{FOURSQUARE_CLIENT_ID}&client_secret=#{FOURSQUARE_CLIENT_SECRET}&v=20140220")
  #   images = from_foursquare["response"]["venues"][0]["categories"].map { |photo| "#{photo["icon"]["prefix"]}" + "#{photophoto["icon"]["suffix"]}" }
  # end

  def load_user
    return @user = User.find(params[:user_id])
  end

  def bar_params
    params.permit(:name, :address, :photo_url, :review) 
  end
end

