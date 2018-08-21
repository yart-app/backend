Rails.application.routes.draw do
  root to: "home#index"
  devise_for :users

  resources :tools
  resources :projects
  resources :posts

  post "projects/update_status", to: "projects#update_status"
  post "projects/update_category", to: "projects#update_category"

  get "profile/:id", to: "users#show", as: "profile"

  scope :users do
    post "follow", to: "users#follow", as: "follow"
    post "unfollow", to: "users#unfollow", as: "unfollow"
    post "toggle_follow", to: "users#toggle_follow", as: "toggle_follow"
  end
end
