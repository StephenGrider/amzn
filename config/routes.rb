Rails.application.routes.draw do
  root to: 'visitors#index'
  devise_for :users
  resources :users
  resources :items, :only => [:index, :show]
  resources :line_items, :only => [:index, :create, :destroy]

  scope 'api/v1' do
    resources :line_items, :only => [:index, :create, :destroy], controller: 'api/v1/line_items'
    resources :items, :only => [:index], controller: 'api/v1/items'
  end

  scope 'admin' do
    get '/', :to => 'admin/admin#index'
    post '/fetch', :to => 'admin/admin#fetch'
  end
end
