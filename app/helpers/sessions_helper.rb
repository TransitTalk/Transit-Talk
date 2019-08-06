# frozen_string_literal: true

module SessionsHelper
  # returns the path from which a user came. A query parameters called "from" must be present for
  # this method to work properly. We'll pass the other query params as query params to the next page
  def inferred_last_page_path(options = {})
    if params[:from].blank?
      return nil
    end

    query_params = options[:allowed_query_params] ?
                     params.slice(*options[:allowed_query_params]).to_query : ""

    params[:from] + "?" + query_params
  end
end
