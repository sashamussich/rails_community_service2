Rails.application.routes.draw do
  root 'home#index'

  # omniauth
  get '/auth/:provider/callback' => 'user_sessions#create'
  get '/auth/failure' => 'user_sessions#failure'

  # Custom logout
  match '/logout', :to => 'user_sessions#destroy', via: :all
end
