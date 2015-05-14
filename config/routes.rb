Rails.application.routes.draw do

  get 'password_resets/new'

  get 'password_resets/edit'

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

  resources :account_activations, only: [:edit]

  resources :password_resets,     only: [:new, :create, :edit, :update]

  resources :videos, only: [:index, :new, :create, :destroy]

  resources :photos

end
