Rails.application.routes.draw do
  get 'dashboard/index'

  post 'login/create'
  root 'hello#index'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
