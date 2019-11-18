# frozen_string_literal: true

class StopsController < ApplicationController
  def nearby
    if has_coordinate_params
      render json: Stop.find_nearby(longitude: params[:longitude], latitude: params[:latitude])
      return
    end

    render json: Stop.take(10).group_by(&:serviced_by)
  end

  def show
    @stop = Stop.includes(:issues).find(params[:stop_id])
  end

  private
  def has_coordinate_params
    params[:longitude].present? && params[:latitude].present?
  end
end
