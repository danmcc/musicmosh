Rails.application.routes.draw do

  root 'users#index'

  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }

  get '/shows/:country/:state/:city', to: 'shows#show', as: 'show_location'

  resource :favorites

end
