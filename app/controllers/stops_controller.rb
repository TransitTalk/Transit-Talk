# frozen_string_literal: true

class StopsController < ApplicationController
  def show
    @stop = Stop.find(params[:stop_id])
  end
end
