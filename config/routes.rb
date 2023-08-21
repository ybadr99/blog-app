Rails.application.routes.draw do
  #users
  root "users#index"
  get "/users/:id", to: "users#show"
  #posts
  get "users/:id/posts", to: "posts#index"
  get "users/:id/posts/:id", to: "posts#show"
end
