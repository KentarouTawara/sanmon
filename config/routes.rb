Rails.application.routes.draw do
  root "top#index"
  resources :users

  resources :works do
    resources :comments, shallow: true
  end

  resources :authors, only: %i[show], param: :pen_name

  resource :dashboard, only: %i[show]
  get 'login' => 'user_sessions#new', :as => :login
  post 'login' => "user_sessions#create"
  delete 'logout' => 'user_sessions#destroy', :as => :logout

  namespace :admin do
    get 'dashboard/index'
    resources :users
    resources :works
  end

  get 'terms', to: 'static_pages#terms'
  get 'privacy', to: 'static_pages#privacy'
end
