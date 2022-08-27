require 'podcast_domain'
Rails.application.routes.draw do
  constraints(PodcastDomain) do
    get '/:podcast/:filename', to: 'hosting#redirect'
    get '*path', to: 'hosting#not_found'
  end
  resources :recordings
  resources :podcasts do
    resources :privileges
  end
  get '/render/:podcast_name', to: 'render#show'
  post '/switch_podcast', to: 'sessions#switch_podcast'
  get '/noprivilege', to: 'request_podcast#index'
  resources :users
  root "home#index"
  get '/login', to: 'sessions#login'
  post '/login', to: 'sessions#create'
  get '/logout', to: 'sessions#destroy'
  post '/logout', to: 'sessions#destroy'
  
end
