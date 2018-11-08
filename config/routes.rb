StreamLine::Application.routes.draw do
  get 'auth/:provider/callback', to: 'sessions#create'
  get 'auth/failure', to: redirect('/')
  get 'signout', to: 'sessions#destroy', as: 'signout'
  get '/auth/:provider/callback' => 'omni_auth#callback'
  get '/auth/failure' => 'omni_auth#failure'

  resources :sessions, only: [:create, :destroy]
  resource :home, only: [:show]
  resources :events
  resources :notes
  resources :users

  root to: "home#show"

end
