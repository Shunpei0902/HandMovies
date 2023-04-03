Rails.application.routes.draw do
  resources :movies

  devise_for :users
  root to: "home#index"

  resources :movies do
    resources :comments, :only => [:create, :destroy]
  end

  resources :users

end
