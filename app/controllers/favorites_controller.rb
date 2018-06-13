# frozen_string_literal: true

class FavoritesController < ApplicationController
  def index
    unless current_user
      redirect_to new_user_session_path
    end
  end

  def new
    @stop = Stop.find(params[:stop_id])
    current_user.favorites << @stop

    respond_to do |format|
      # using locals so we can pass in stop in the stops/show partial and lines/show view
      format.js { render "new.js.erb", locals: { stop: @stop } }
    end
  end

  def delete
    @stop = Stop.find(params[:stop_id])
    current_user.favorites.delete(@stop)

    respond_to do |format|
      # using locals so we can pass in stop in the stops/show partial and lines/show view
      format.js { render "delete.js.erb", locals: { stop: @stop } }
    end
  end
end
