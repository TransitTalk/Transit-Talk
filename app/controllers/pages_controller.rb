# frozen_string_literal: true

class PagesController < ApplicationController
  def view_issues
    # If rails is not prod, just take the top 50 stops.
    # There is a known issue with SQLite and the geolocation gem
    if !Rails.env.production?
      @top_bus_stops = Stop.includes(:lines, :issues).where(serviced_by: "bus").take(10)
      @top_train_stops = Stop.includes(:lines, :issues).where(serviced_by: "metro").take(10)
      @nearby_stops = { "bus" => @top_bus_stops, "train" => @top_train_stops }
    # If our location.js has pulled a location, use it to find Stops
    elsif (params[:lat]) && (params[:long])
      @nearby_stops_req = Stop.includes(:lines, :issues).within(0.2, origin: [params[:lat], params[:long]]).group_by(&:serviced_by)
      @nearby_stops = { "bus" => @nearby_stops_req.fetch("bus", []), "train" =>  @nearby_stops_req.fetch("metro", []) +  @nearby_stops_req.fetch("tram", []) }
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
    @result_lines = Line.includes(:stops).where(
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
