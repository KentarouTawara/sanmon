Rails.application.routes.draw do
  root "top#index"
  resources :users
end
