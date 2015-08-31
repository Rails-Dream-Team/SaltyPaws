Rails.application.routes.draw do
  require 'sidekiq/web'
  devise_for :users
  ActiveAdmin.routes(self)

  root 'home#index'

  resources :colonies
  resources :organizations do
    member do
      get :join
      get :leave
    end
  end

  resources :cats
  resources :users, only: [:edit, :show, :update]

  resources :boards
  resources :topics do
    resources :posts
  end

  resources :volunteers, only: [:new, :create]

  resources :reports, only: [:new, :create]

  mount Sidekiq::Web => '/sidekiq'
end
