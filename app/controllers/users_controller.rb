class UsersController < ApplicationController

 before_action :load_user, only: [:show, :edit, :update, :destroy]

  def new 
    @user = User.new
    render :new
  end

  def create
    @user = User.new(user_params)
    @user.latitude = location.latitude
    @user.longitude = location.longitude
    # @user.ip_address
    # geocode_ip_address
    if @user.save
      redirect_to user_path(@user)
    else
      render :new
    end
  end

  def show
    @location = @user.locations.all
    # @custom_location = get_bar_name(params[:custom_location])
  end

  def edit
    @update_worked = true
  end

  def update
    @update_worked = @user.update(user_params)

    if @update_worked
      redirect_to user_path(@user)
    else
      render :edit
    end
  end

  def destroy
    @user.destroy
    session.destroy
    redirect_to root_path
  end

  def load_user
    return @user = User.find(params[:id])
  end 

  # def ip_address
  #   if request.location == '127.0.0.1'
  #     # Hard coded remote address
  #     "123.45.67.89"
  #   else
  #     request.location
  #   end
  # end
   

private 

  def user_params
    params.require(:user).permit(:email, :firstname, :lastname, :dob, :facebook_link, :password, :password_confirmation, :latitude, :longitude, :ip_address)
  end

#   def custom_bar_name(latitude, longitude)
#     binding.pry
#     from_yelp = HTTParty.get("http://api.yelp.com/business_review_search?term=happy+hour&lat=#{latitude}&long=#{longitude}&radius=10&limit=5&ywsid=#{YELP_CLIENT_ID}")
#     bar_name = from_yelp["businesses"]
#     saved_bars = []
#     select_bar_names = bar_name.each{ |bar| saved_bars << {"Name" => "#{bar["name"]}", "Location" => "#{bar["address1"]}", "Photo" => "#{bar["photo_url"]}", "url" => "#{bar["url"]}" } }
#     saved_bars
# end

# def get_bar_name(location)
#   # location = @User.locations.address
#   from_yelp = HTTParty.get("http://api.yelp.com/business_review_search?term=happy+hour&location=#{location}&ywsid=pciSmjmZPLGRzQTqu9mh8g")
#   bar_name = from_yelp["businesses"]
#   # select_bar_names = bar_name.map{ |bar| bar["name"] }
# end

end