# frozen_string_literal: true

class FavoritesController < ApplicationController
  def index
    unless current_user
      redirect_to new_user_session_path
    end
  end

  def new
    current_user.favorites << Stop.find(params[:stop_id])
    redirect_to favorites_path
  end

  def delete
    current_user.favorites.delete(Stop.find(params[:stop_id]))
    redirect_to favorites_path
  end
end
