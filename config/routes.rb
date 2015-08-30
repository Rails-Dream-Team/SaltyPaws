Rails.application.routes.draw do
  require 'sidekiq/web'
  devise_for :users
  ActiveAdmin.routes(self)

  root 'home#index'

  resources :colonies
  resources :organizations
  resources :cats
  resources :users, only: [:edit, :update]
  get '/users/:id' => 'users#show'
  resources :boards
  resources :topics do
    resources :posts
  end

  get 'volunteers', to: 'volunteers#new', as: 'volunteer'
  post 'volunteers', to: 'volunteers#create'

  get 'reports', to: 'reports#new', as: 'report'
  post 'reports', to: 'reports#create'

  mount Sidekiq::Web => '/sidekiq'
end
