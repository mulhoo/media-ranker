Rails.application.routes.draw do
  root 'homepage#index'
  resources :works
  resources :users
  
  get "/login", to: "users#login_form", as: "login"
  post "/login", to: "users#login"
  post "/logout", to: "users#logout", as: "logout"
  get "/users/current", to: "users#current", as: "current_user"
  
  get '/vote/:id', to: 'votes#vote_by_work_id', as: 'vote_by_work_id'
  get '/homepage', to: 'homepage#index'
end
