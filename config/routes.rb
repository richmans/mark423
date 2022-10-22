Rails.application.routes.draw do
  get '/podcasts/:podcast/podcast', to: 'hosting#fetch_podcast'
  get '/podcasts/:podcast/:filename', to: 'hosting#fetch_recording'
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
  get '/forgot', to: 'recover#new'
  post '/forgot', to: 'recover#create', as: "create_recovery"
  get '/forgot/reset', to: 'recover#use', as: "use_recovery"
  post '/forgot/reset', to: 'recover#reset'
  root "home#index"
end
