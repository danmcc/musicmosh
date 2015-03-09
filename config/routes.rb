Rails.application.routes.draw do

  root 'users#index'

  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }

  get '/shows/:country/:state/:city', to: 'shows#location', as: 'show_location'

  resources :artists
  resources :venues
  resources :favorites
  resources :thumbs_down

end
