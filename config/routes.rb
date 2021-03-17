Rails.application.routes.default_url_options[:host] = 'localhost:3001'

Rails.application.routes.draw do

  resources :mods
  resources :meals
  resources :ingredients
  resources :my_objectives
  namespace :api, defaults: { format: :json } do
    resources :users, only: %w[show]
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
