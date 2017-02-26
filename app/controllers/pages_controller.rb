class PagesController < ApplicationController
  def show
    if valid_page?
        render template: "pages/#{params[:page_name]}"
    else
        render file: "public/404.html", status: :not_found
    end
  end

  def search
    @result_lines = Line.where("name like ?", "%#{params[:q]}%")
    @result_stops = Stop.where("name like ?", "%#{params[:q]}%")
  end
  
  def valid_page?
    File.exist?(Pathname.new(Rails.root + "app/views/pages/#{params[:page_name]}.html.erb"))
  end
end
