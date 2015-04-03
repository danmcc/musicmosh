Rails.application.routes.draw do

  root 'users#index'

  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }

  get '/shows/:country/:state/:city', to: 'shows#location', as: 'show_location'

  get '/shows/:lat/:lon', to: 'shows#location', as: 'show_location_coordinates', :constraints => { :lat => /.*/, :lon => /.*/ }

  get '/users/manage', to: 'users#manage', as: 'manage_users_likes'

  resources :artists
  resources :venues
  resources :favorites
  resources :thumbs_down
  resources :reports

end
