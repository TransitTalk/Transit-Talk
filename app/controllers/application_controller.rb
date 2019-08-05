# frozen_string_literal: true

class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper

  # override devise's method of the same name
  # take user back to last page if available
  def after_sign_in_path_for(resource_or_scope)
    inferred_last_page_path.blank? ?
      super : inferred_last_page_path(allowed_query_params: :line_type)
  end
end
