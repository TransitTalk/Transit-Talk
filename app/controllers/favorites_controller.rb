class FavoritesController < ApplicationController
  def index
      unless current_user
        redirect_to new_user_session_path
      end
  end

  def new
    current_user.favorites << Stop.find(params[:stop_id])
    render json: {
      message: "Favorite has been added successfully.",
      status: 201
    }, status: 201
  end

  def delete
    current_user.favorites.delete(Stop.find(params[:stop_id]))
    render json: {
      message: "Favorite has been deleted successfully.",
      status: 204
    }, status: 204
  end
end
