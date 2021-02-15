Rails.application.routes.draw do
  devise_for :users

  root to: 'posts#index'

  resources :users, only: [:index, :show]
  resources :friend_requests, only: [:create, :destroy]
  resources :friendships, only: [:create, :destroy]
  resources :likes, only: [:create, :destroy]
  resources :posts
  resources :comments

  get 'likes', to: 'posts#index'
  post 'posts/:id/edit', to: 'posts#update'

  post 'posts/new',    to: 'posts#create'
  post 'comments/new', to: 'comments#create'
  post 'users/:id',    to: 'posts#create'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
