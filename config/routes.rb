Rails.application.routes.draw do



  root to: 'posts#index'

  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'

  resources :posts, only:[:index, :new, :create]

  resources :users

  resources :relationships, only:[:create, :destroy]




end
