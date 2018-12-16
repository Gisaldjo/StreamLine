StreamLine::Application.routes.draw do
  resources :tasks
  get 'auth/:provider/callback', to: 'sessions#create'
  get 'auth/failure', to: redirect('/')
  get 'signout', to: 'sessions#destroy', as: 'signout'
  get 'profile', to: 'home#profile'
  post 'profile', to: 'home#edit_user'
  get 'settings', to: 'home#settings'
  get '/calendars', to: 'tasks#get_calendar_events', as: 'calendars'
  

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