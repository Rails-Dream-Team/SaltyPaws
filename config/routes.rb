Rails.application.routes.draw do

  devise_for :users
  root 'home#index'

  resources :colonies
  resources :organizations
  resources :cats

  mount Thredded::Engine => '/forum'

end
