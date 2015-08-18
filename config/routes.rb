Rails.application.routes.draw do

  devise_for :users
  root 'home#index'

  resources :colonies
  mount Thredded::Engine => '/forum'

end
