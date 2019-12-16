# frozen_string_literal: true

class PagesController < ApplicationController
  def home
    @favorites = user_signed_in? ? current_user.favorites : []
  end

  def show
    if valid_page?
      render template: "pages/#{params[:page_name]}"
    else
      render file: "public/404.html", status: :not_found
    end
  end

  def search
    @result_lines = Line.includes(:stops).where(
      "name LIKE ? OR route_long_name LIKE ?", "%#{params[:q]}%", "%#{params[:q]}%"
    ).take(25)
    @result_stops = Stop.includes(:lines).where(
      "stops.name LIKE ?", "%#{params[:q]}%").order("lines.vehicle_type DESC"
    ).take(25)
  end

  def valid_page?
    File.exist?(Pathname.new(Rails.root + "app/views/pages/#{params[:page_name]}.html.erb"))
  end
end
