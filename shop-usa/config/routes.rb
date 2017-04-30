Rails.application.routes.draw do

  devise_for :users, :controllers => {:registrations => 'registrations'}
  resources :orders
  resources :products, only: [:index, :create]
  resource :cart, only: [:show]
  resources :order_items, only: [:create, :update, :destroy]
  resources :home, only: [:create]

  root to: 'home#index'

  get '/myorders', to: 'orders#user_index', as: 'myorders'
  post '/pay/:id', to: 'orders#pay'
  post '/pay', to: 'order_items#pay'

  get '/how-it-works', to: 'home#how_it_works'
  get '/enterprise', to: 'home#enterprise'
  get '/guest', to: 'home#guest'

end
