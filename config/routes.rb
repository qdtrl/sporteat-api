Rails.application.routes.default_url_options[:host] = 'localhost:3001'

Rails.application.routes.draw do
  # MEAL
  resources :mods
  resources :meals
  resources :ingredients
  resources :my_objectives

  
  # WORKOUT
  resources :my_performances, only: [:index, :create]
  resources :my_equipements, only: [:index, :update, :destroy]
  resources :equipements, only: [:index]
  resources :exercices, only: [:index, :show]
  resources :wods, only: [:index, :create, :destroy]

  # USER
  namespace :api, defaults: { format: :json } do
    resources :users, only: [:show, :update]
  end

  devise_for :users,
    defaults: { format: :json },
    path: '',
    path_names: {
      sign_in: 'api/login',
      sign_out: 'api/logout',
      registration: 'api/signup'
    },
    controllers: {
      sessions: 'sessions',
      registrations: 'registrations'
    }

end
