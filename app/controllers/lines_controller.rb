# frozen_string_literal: true

class LinesController < ApplicationController
  def index
    @lines = Line.includes(:issues).all.sort_by { |l| -l.name.to_i }.sort_by { |l| l.vehicle_type }.reverse!
  end

  def show
    @line = Line.includes(stops: [:issues]).find(params[:id])
  end

  def get_stops
    @line = Line.find(params[:line_id])
    render json: @line.stops.pluck(:onestop_id, :name)
  end

  def get_stops_map
	@line = Line.find(params[:line_id])
	render json: @line.stops.select(:onestop_id, :name, :lattitude, :longitude)
  end
end
