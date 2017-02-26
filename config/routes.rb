Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  # General page routes. Will include items like home and top-level pages
  get "/pages/:page_name" => 'pages#show', :as => :page

  # get "/lines" => 'lines#index', :as => :lines
  # get "/lines/:name" => 'lines#show', :as => :lines_name

  resources :lines, only: [:index, :show]

  get "/stops/:stop_id" => 'stops#show', :as => :stops
#  get "/line" name: "vehicles"

  get "/search" => 'pages#search', :as => :search


  get "/favorites" => 'favorites#index', :as => :favorites
  get "/favorite/:stop_id" => 'favorites#new', :as => :favorite
  get "/unfavorite/:stop_id" => 'favorites#delete', :as => :unfavorite

  root 'pages#dashboard'

end
