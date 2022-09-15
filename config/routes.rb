Rails.application.routes.draw do
  get '/published/:podcast/podcast', to: 'hosting#fetch_podcast'
  get '/published/:podcast/:filename', to: 'hosting#fetch_recording'
  get '/published/*path', to: 'hosting#not_found'
  scope '/admin' do
    resources :recordings
    resources :podcasts do
      resources :privileges
    end
    resources :users
    get '/render/:podcast_name', to: 'render#show'
    post '/switch_podcast', to: 'sessions#switch_podcast'
    get '/noprivilege', to: 'request_podcast#index'  
  end
  
  get '/login', to: 'sessions#login'
  post '/login', to: 'sessions#create'
  get '/logout', to: 'sessions#destroy'
  post '/logout', to: 'sessions#destroy'
  root "home#index"
end
