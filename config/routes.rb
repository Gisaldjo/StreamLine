StreamLine::Application.routes.draw do
  get 'auth/:provider/callback', to: 'sessions#create'
  get 'auth/failure', to: redirect('/')
  get 'signout', to: 'sessions#destroy', as: 'signout'
  get 'profile', to: 'home#profile'
  get 'settings', to: 'home#settings'

  resources :sessions, only: [:create, :destroy]
  resource :home
  resources :users
  resources :notes
  resources :tasks

  root to: "home#show"
end