Rails.application.routes.draw do
  root to: "home#index"
  devise_for :users

  resources :tools, except: :new
  resources :projects
end
