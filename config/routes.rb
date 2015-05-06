Rails.application.routes.draw do

  get 'signup' =>  'users#new'
  get 'users/index'

  get 'photos/index'

  root 'static_pages#home'
  get 'day' => 'static_pages#day'
  get 'weekend' => 'static_pages#weekend'
  get 'korobovka' => 'static_pages#korobovka'
  get 'stayki' => 'static_pages#stayki'

  resources :videos, only: [:index, :new, :create, :destroy]
  resources :photos

end
