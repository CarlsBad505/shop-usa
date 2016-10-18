Rails.application.routes.draw do
  devise_for :users
  
  resources :orders
  
  root to: 'home#index'
  
  get '/myorders', to: 'orders#user_index', as: 'myorders'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
