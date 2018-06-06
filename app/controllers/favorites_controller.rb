# frozen_string_literal: true

class FavoritesController < ApplicationController
  def index
    unless current_user
      redirect_to new_user_session_path
    end
  end

  def new
    # Get the stop from the URL parameter
    @stop = Stop.find(params[:stop_id])

    # Add the stop to the user's favorites
    current_user.favorites << @stop

    respond_to do |format|
      # A normal HTML request was recieved
      format.html { redirect_to favorites_path }

      # Respond with JS partial
      format.js

      # A request for JSON was recieved
      format.json {
        render json: {
          message: "Favorite has been added successfully.",
          status: 201
        }, status: 201
      }
    end
  end

  def delete
    @stop = Stop.find(params[:stop_id])
    current_user.favorites.delete(Stop.find(params[:stop_id]))
    @should_remove_element = URI(request.referer).path == favorites_path

    respond_to do |format|
      # A normal HTML request was recieved
      format.html { redirect_to favorites_path }

      # Respond with JS partial
      format.js

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
