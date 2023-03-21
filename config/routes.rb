Rails.application.routes.draw do
  resources :movies

  devise_for :users
  root to: "home#index"

  resources :users

end
