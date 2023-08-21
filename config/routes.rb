Rails.application.routes.draw do
  #users
  root "users#index"
  #posts
  resources :users, only: [:index, :show] do
    resources :posts, only: [:index, :show]
  end
end
