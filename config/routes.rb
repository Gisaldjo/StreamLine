StreamLine::Application.routes.draw do
  resources :tasks
  get 'auth/:provider/callback', to: 'sessions#create'
  get 'auth/failure', to: redirect('/')
  get 'signout', to: 'sessions#destroy', as: 'signout'

  resources :sessions, only: [:create, :destroy]
  resource :home
  resources :users
  resources :notes do
    member do
      post 'change_color'
      post 'move'
    end
  end
  resources :tasks

  root to: "home#show"
end