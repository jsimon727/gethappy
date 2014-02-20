class UsersController < ApplicationController

 before_action :load_user, only: [:show, :edit, :update, :destroy]
 before_action :authenticate, :authorize, only: [:edit, :update, :show]

  def new 
    @user = User.new
    render :new
  end

  def create
    @user = User.new(user_params)
    @user.latitude = location.latitude
    @user.longitude = location.longitude
    if @user.save
      redirect_to user_path(@user)
    else
      render :new
    end
  end

  def show
    @location = @user.locations.all
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

  def authenticate
    unless logged_in?
      redirect_to login_path
    end
  end

  def authorize
    unless current_user == @user
      redirect_to login_path
    end
  end

private 

  def user_params
    params.require(:user).permit(:email, :firstname, :lastname, :dob, :facebook_link, :password, :password_confirmation, :latitude, :longitude, :ip_address)
  end

end