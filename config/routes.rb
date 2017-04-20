Rails.application.routes.draw do
  get 'sessions/new'

  get 'sessions/create'

  get 'sessions/destroy'

  get 'users/index'

  get 'users/show'
  
  get 'signup', to: 'users#new'
  
  
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
  
  root to: 'toppages#index'
  
  #root to: 'tasks#index'
  resources :users, only: [:index, :show, :new, :create]
  resources :txtmemos
end