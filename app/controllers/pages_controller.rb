class PagesController < ApplicationController
  def home
      render 'home'
  end
  def about
      render 'about'
  end
  def dash
      render 'dashboard'
  end
end
