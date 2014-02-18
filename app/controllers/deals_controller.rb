class DealsController < ApplicationController
  before_action(:load_location, { only: [:edit, :update, :destroy] })

  def new
    @deal = Deal.new
  end

  def edit
  end

  def index
    @deals = Deal.all
    @location = Location.find(params[:location_id])
    @deals_show = get_deals(@location.zip_code || @location.neighborhood)
  end

  def show
    @user = User.find(params[:user_id])
    @custom_deals_show = custom_get_deals(@user.latitude, @user.longitude)
  end



  private

  def get_deals(search_location)
    from_coupons = HTTParty.get("http://api.8coupons.com/v1/getdeals?key=#{COUPON_CLIENT_ID}&zip=#{search_location}&mileradius=10&limit=1000&orderby=radius&dealtypeid=7")
    saved_coupons = []
    select_coupons = from_coupons.select{ |coupon| saved_coupons << {"Name" => "#{coupon["dealTitle"]}", "Location" => "#{coupon["name"]}", "Address" => "#{coupon["address"]}", "Disclaimer" => "#{coupon["disclaimer"]}", "Photo" => "#{coupon["showImageStandardBig"]}", "url" => "#{coupon["homepage"]}" } }
    saved_coupons
  end

  def custom_get_deals(latitude, longitude)
    from_coupons = HTTParty.get("http://api.8coupons.com/v1/getdeals?key=#{COUPON_CLIENT_ID}&lat=#{latitude}&lon=#{longitude}&mileradius=10&limit=1000&orderby=radius&dealtypeid=7")
    saved_coupons = []
    select_coupons = from_coupons.select{ |coupon| saved_coupons << {"Name" => "#{coupon["dealTitle"]}", "Location" => "#{coupon["name"]}", "Address" => "#{coupon["address"]}", "Disclaimer" => "#{coupon["disclaimer"]}", "Photo" => "#{coupon["showImageStandardBig"]}", "url" => "#{coupon["homepage"]}" } }
    saved_coupons
  end


  def load_user
    return @user = User.find(params[:user_id])
  end

  def load_location
    return @location = Location.find(params[:id])
  end

  def location_params
    params.require(:location).permit(:name, :type, :deal_price, :original_price, :info)
  end

end