class LinesController < ApplicationController
  def index
    @lines = Line.all.order(:system_type)
  end

  def show
    @line = Line.find(params[:id])
  end
end
