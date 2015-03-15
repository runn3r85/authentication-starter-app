Rails.application.routes.draw do
  resources :users, except: :index

  # Static Pages generic
  get '/:action', controller: :pages, as: :pages
  root 'pages#home'
end
