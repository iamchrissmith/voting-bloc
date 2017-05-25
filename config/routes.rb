Rails.application.routes.draw do
  root to: 'sessions#new'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'

  resources :users, except: [:index, :destroy]

  namespace :admin do
    resources :users, only: [:index, :destroy]
  end
end
