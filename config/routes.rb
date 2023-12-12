Rails.application.routes.draw do
  devise_for :users
  
  get 'cart/show'
  post 'cart/add'
  post 'cart/remove'

  resources :products
  get "up" => "rails/health#show", as: :rails_health_check

  root "home#index"
end
