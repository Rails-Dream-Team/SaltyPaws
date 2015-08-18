Rails.application.routes.draw do

  devise_for :users
  root 'home#index'

  mount Thredded::Engine => '/forum'

end
