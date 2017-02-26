Rails.application.routes.draw do
  resources :issues
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  # General page routes. Will include items like home and top-level pages
  get "/pages/:page_name" => 'pages#show', :as => :page

  # get "/lines" => 'lines#index', :as => :lines
  # get "/lines/:name" => 'lines#show', :as => :lines_name

  resources :lines, only: [:index, :show]

  get "/stops/:stop_id" => 'stops#show', :as => :stops
  get "/favorites" => 'stops#fav', :as => :favorites
#  get "/line" name: "vehicles"

  get "/search" => 'pages#search', :as => :search

  root 'pages#dashboard'

end
