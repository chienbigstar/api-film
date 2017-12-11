Rails.application.routes.draw do
  get 'requests/code'
  
  resources :pages
  resources :accounts
  resources :configs

  root 'hello#index'
  get 'dashboard/index'
  post 'login/create'
  delete 'login/destroy'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
