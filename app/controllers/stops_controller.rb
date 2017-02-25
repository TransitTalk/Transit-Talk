class StopsController < ApplicationController
  def show
  end

  def fav
      if current_user
        render 'fav'
      else
        redirect_to new_user_session_path
      end
  end
end
