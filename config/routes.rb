Rails.application.routes.draw do

  devise_for :users
  root 'home#index'

  resources :colonies
  resources :organizations
  resources :cats
  resources :users, only: [:show, :edit, :update]

  mount Thredded::Engine => '/forum'

end
