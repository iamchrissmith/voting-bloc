Rails.application.routes.draw do
  root to: 'sessions#new'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'

  resources :users, except: [:index, :destroy]
  resources :elections, except: [:new, :create, :destroy, :edit]

  namespace :admin do
    resources :users, only: [:index, :destroy]
    resources :elections, only: [:new, :create, :destroy, :edit]
  end

  namespace :candidates do
    post '/:user_id/elections/:id', to: 'election#update'
  end
end
