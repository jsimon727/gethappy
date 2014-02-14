class FavoritesController < ApplicationController

  def new 
    @favorite = Favorite.new
  end

  def create
    @favorite = Favorite.new(favorite_params)
    @favorite.user = @user
    @favorite.save
    redirect_to user_path(@user)
  end

  def edit    
  end

  def update
    @favorite.update(favorite_params)
    redirect_to user_path(@user)
  end


  def destroy
    @favorite.destroy
    redirect_to user_path(@user)
  end

end

