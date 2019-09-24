# frozen_string_literal: true

class LinesController < ApplicationController
  def index
    @lines = Line.all.sort_by { |l| -l.name.to_i }.sort_by { |l| l.vehicle_type }.reverse!
  end

  def show
    @line = Line.find(params[:id])
  end

  def get_stops
    @line = Line.find(params[:line_id])
    render json: @line.stops.pluck(:onestop_id, :name)
  end
end
