# frozen_string_literal: true

class StopsController < ApplicationController
  # not called directly, called by JS
  def nearby
    unless has_coordinate_params
      render status: :no_content
      return
    end

    @nearby_stops = Stop.find_nearby(longitude: params[:longitude], latitude: params[:latitude])
    render partial: "stops/nearby_table", layout: false
  end

  def show
    @stop = Stop.includes(:issues).find(params[:stop_id])
  end

  private
  def has_coordinate_params
    params[:longitude].present? && params[:latitude].present?
  end
end
