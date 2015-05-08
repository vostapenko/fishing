Rails.application.routes.draw do

  root 'static_pages#home'                   

  get 'day'         => 'static_pages#day'            
  get 'weekend'     => 'static_pages#weekend'    
  get 'korobovka'   => 'static_pages#korobovka'
  get 'stayki'      => 'static_pages#stayki'      

  get    'signup'   =>  'users#new'
  get    'login'    => 'sessions#new'
  post   'login'    => 'sessions#create'
  delete 'logout'   => 'sessions#destroy'

  resources :users

  resources :videos, only: [:index, :new, :create, :destroy]

  resources :photos

end
