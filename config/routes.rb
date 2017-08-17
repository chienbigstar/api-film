Rails.application.routes.draw do
  resources :pages
  resources :accounts

  root 'hello#index'
  get 'dashboard/index'
  post 'login/create'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
