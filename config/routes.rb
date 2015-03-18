Rails.application.routes.draw do

  # User Sessions, Password Resets
  get '/sign-in', to: "user_sessions#new", as: :sign_in
  delete '/sign-out', to: "user_sessions#destroy", as: :sign_out
  get '/register', to: "users#new", as: :register
  resources :user_sessions, only: [:create]
  # resources :password_resets, only: [:new, :create, :edit, :update], path: "password"
  resources :users, only: [:show, :create, :update, :edit, :destroy]

  get '/dashboard', to: 'pages#dashboard', as: :dashboard

  # Static Pages generic
  get '/:action', controller: :pages, as: :pages
  root 'pages#home'
end
