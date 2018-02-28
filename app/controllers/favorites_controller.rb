class FavoritesController < ApplicationController
  def index
      unless current_user
        redirect_to new_user_session_path
      end
  end

  def new
    current_user.favorites << Stop.find(params[:stop_id])

    respond_to do |format|
      # A normal HTML request was recieved
      format.html { redirect_to favorites_path }

      # An AJAX request was recieved
      format.json {
        render json: {
          message: "Favorite has been added successfully.",
          status: 201
        }, status: 201
      }
    end
  end

  def delete
    current_user.favorites.delete(Stop.find(params[:stop_id]))

    respond_to do |format|
      # A normal HTML request was recieved
      format.html { redirect_to favorites_path }

      # An AJAX request was recieved
      format.json {
        render json: {
          message: "Favorite has been deleted successfully.",
          status: 204
        }, status: 204
      }
    end
  end

end
