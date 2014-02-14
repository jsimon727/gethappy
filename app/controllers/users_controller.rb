class UsersController < ApplicationController

 before_action :load_user, only: [:show, :edit, :update, :destroy]

  def new 
    @user = User.new
    render :new
  end


  def create
    @user = User.new(user_params)

    if @user.save
      redirect_to user_path(@user)
    else
      render :new
    end
  end

  def show
  @location = Location.all
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

  def user_params
    params.require(:user).permit(:email, :firstname, :lastname, :dob, :facebook_link, :password, :password_confirmation)
  end


end