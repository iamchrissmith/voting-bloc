Rails.application.routes.draw do
  root to: 'sessions#new'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'

  resources :users, except: [:index, :destroy] do
    put :become_candidate
  end

  resources :elections, only: [:index, :show]

  resources :votes, only: [:index, :create]

  namespace :admin do
    resources :users, only: [:index, :destroy]
    resources :elections, only: [:new, :create, :destroy, :edit, :update]
  end

  namespace :candidates do
    post '/:user_id/elections/:id', to: 'elections#update'
  end
end
