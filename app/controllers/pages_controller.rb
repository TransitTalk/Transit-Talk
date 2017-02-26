class PagesController < ApplicationController
  def dashboard
      if ((params[:lat]) && (params[:long]))
          @nearby_stops = Stop.within(0.2, :origin => [params[:lat],params[:long]])
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
    @result_lines = Line.where("name like ?", "%#{params[:q]}%")
    @result_stops = Stop.includes(:lines).where("stops.name like ? AND stops.twin_stop_id IS NULL AND lines.system_type NOT NULL", "%#{params[:q]}%").order("lines.system_type")
  end
  
  def valid_page?
    File.exist?(Pathname.new(Rails.root + "app/views/pages/#{params[:page_name]}.html.erb"))
  end
end
