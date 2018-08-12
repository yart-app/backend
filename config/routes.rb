Rails.application.routes.draw do
  root to: "home#index"
  devise_for :users

  resources :tools
  resources :projects
  resources :posts

  post "projects/update_status", to: "projects#update_status"
  post "projects/update_category", to: "projects#update_category"

  get "profile/:id", to: "users#show", as: "profile"
end
