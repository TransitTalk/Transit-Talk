# frozen_string_literal: true

class PagesController < ApplicationController
  def view_issues
    # If our location.js has pulled a location, use it to find Stops
    if ((params[:lat]) && (params[:long]))
      @nearby_stops = Stop.includes(:lines).within(0.2, origin: [params[:lat], params[:long]])
    end
  end

  def show
    if valid_page?
      render template: "pages/#{params[:page_name]}"
    else
      render file: "public/404.html", status: :not_found
    end
  end

  def search
    @result_lines = Line.where(
      "name LIKE ? OR route_long_name LIKE ?", "%#{params[:q]}%", "%#{params[:q]}%"
    )
    @result_stops = Stop.includes(:lines).where(
      "stops.name LIKE ?", "%#{params[:q]}%").order("lines.vehicle_type DESC"
    )
  end

  def valid_page?
    File.exist?(Pathname.new(Rails.root + "app/views/pages/#{params[:page_name]}.html.erb"))
  end
end
