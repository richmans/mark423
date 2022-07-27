Rails.application.routes.draw do
  resources :privileges
  resources :recordings
  resources :podcasts 
  resources :users
  root "home#index"
  get '/login', to: 'sessions#login'
  post '/login', to: 'sessions#create'
  get '/logout', to: 'sessions#destroy'
  post '/logout', to: 'sessions#destroy'

end
