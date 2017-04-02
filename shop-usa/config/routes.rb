Rails.application.routes.draw do

  devise_for :users
  resources :orders
  resources :products, only: [:index]
  resource :cart, only: [:show]
  resources :order_items, only: [:create, :update, :destroy]

  root to: 'home#index'

  get '/myorders', to: 'orders#user_index', as: 'myorders'
  post '/pay/:id', to: 'orders#pay'

end
