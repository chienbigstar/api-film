Rails.application.routes.draw do
  mount ActionCable.server => '/cable'
  resources :groups

  get 'tools/index'
  get 'tools/page_factory'

  get 'info/index'
  get 'info/login_facebook'
  get 'info/do_login_facebook'
  get 'info/anticaptcha'
  get 'info/cheapcaptcha'
  get 'info/banner'

  get 'requests/new'
  get 'requests/update'
  get 'requests/report'
  get 'requests/data'
  get 'requests/add_data'

  resources :slots
  resources :backups
  resources :pages do
    collection do
      get :apply
      get :trade
      post :do_trade
    end
  end
  resources :accounts do
    collection do
      get :copy
    end
  end
  resources :standards
  resources :users

  root 'hello#index'
  get 'dashboard/index'
  post 'login/create'
  delete 'login/destroy'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
