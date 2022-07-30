Rails.application.routes.draw do
  resources :recordings
  resources :podcasts do
    resources :privileges
  end
  post '/switch_podcast', to: 'sessions#switch_podcast'
  get '/noprivilege', to: 'request_podcast#index'
  resources :users
  root "home#index"
  get '/login', to: 'sessions#login'
  post '/login', to: 'sessions#create'
  get '/logout', to: 'sessions#destroy'
  post '/logout', to: 'sessions#destroy'

end
