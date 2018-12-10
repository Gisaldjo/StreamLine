StreamLine::Application.routes.draw do
  get 'auth/:provider/callback', to: 'sessions#create'
  get 'auth/failure', to: redirect('/')
  get 'signout', to: 'sessions#destroy', as: 'signout'
  get 'profile', to: 'home#profile'
  post 'profile', to: 'home#edit_user'
  get 'settings', to: 'home#settings'
  

  resources :sessions, only: [:create, :destroy]
  resource :home
  resources :users
  resources :notes do
    member do
      post 'change_color'
    end
  end
  resources :tasks

  root to: "home#show"
end