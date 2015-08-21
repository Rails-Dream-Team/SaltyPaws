Rails.application.routes.draw do
  require 'sidekiq/web'
  devise_for :users
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  root 'home#index'

  resources :colonies
  resources :organizations
  resources :cats
  resources :users, only: [:show, :edit, :update]

  mount Thredded::Engine => '/forum'
  mount Sidekiq::Web => '/sidekiq'
end
