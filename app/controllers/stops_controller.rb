# frozen_string_literal: true

class StopsController < ApplicationController
  def show
    @stop = Stop.includes(:issues).find(params[:stop_id])
  end
end
