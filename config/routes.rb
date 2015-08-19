Rails.application.routes.draw do

  devise_for :users
  root 'home#index'

  resources :colonies
  resources :organizations
  
  mount Thredded::Engine => '/forum'

end
