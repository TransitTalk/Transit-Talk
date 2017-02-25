Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  # General page routes. Will include items like home and top-level pages
  get "/home" => 'pages#home', :as => :home
  get "/page/:page_name" => 'pages#about', :as => :about

  get "/dashboard" => 'pages#dash', :as => :dash

  # get "/lines" => 'lines#index', :as => :lines
  # get "/lines/:name" => 'lines#show', :as => :lines_name

  resources :lines, only: [:index, :show]

  get "/stops/:stop_id" => 'stops#show', :as => :stops
  get "/favorites" => 'stops#fav', :as => :favorites
#  get "/line" name: "vehicles"

  root 'pages#home'

end
