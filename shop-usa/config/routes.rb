Rails.application.routes.draw do
  devise_for :users
  
  resources :orders
  
  root to: 'home#index'
  
  get '/myorders', to: 'orders#user_index', as: 'myorders'
  post '/pay/:id', to: 'orders#pay'

end
