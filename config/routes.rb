Rails.application.routes.draw do
  root "top#index"
  resources :users

  resources :works do
    resources :comments, shallow: true
  end

  resource :dashboard, only: %i[show]
  get 'login' => 'user_sessions#new', :as => :login
  post 'login' => "user_sessions#create"
  delete 'logout' => 'user_sessions#destroy', :as => :logout
end
