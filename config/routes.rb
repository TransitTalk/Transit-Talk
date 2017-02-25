Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  # General page routes. Will include items like home and top-level pages
  get "/home" => 'home#index', :as => :home

  root 'home#index'

end
