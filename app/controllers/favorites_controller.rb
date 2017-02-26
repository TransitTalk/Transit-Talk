class FavoritesController < ApplicationController
  def new
    current_user.favorites << Stop.find(params[:stop_id])
    redirect_to "/favorites"
  end

  def delete
    current_user.favorites.delete(Stop.find(params[:stop_id]))
    redirect_to "/favorites"
  end
end
