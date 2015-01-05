Rails.application.routes.draw do
  root to: 'visitors#index'
  devise_for :users
  resources :users
  resources :items, :only => [:index, :show]
  resources :line_items, :only => [:index, :create]
end
