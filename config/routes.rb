StreamLine::Application.routes.draw do
  resources :notes
  resources :tasks
  get 'auth/:provider/callback', to: 'sessions#create'
  get 'auth/failure', to: redirect('/')
  get 'signout', to: 'sessions#destroy', as: 'signout'
  get 'profile', to: 'home#profile'
  post 'profile', to: 'home#edit_user'
  get 'settings', to: 'home#settings'
  

  resources :sessions, only: [:create, :destroy]
  resource :home
  resources :users

  root to: "home#show"
end