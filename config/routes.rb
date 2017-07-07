Rails.application.routes.draw do
  get 'domains/login'

  resources :domains
end
