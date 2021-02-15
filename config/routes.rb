Rails.application.routes.draw do
  devise_for :users

  root to: 'posts#index'
  resources :friend_requests, only: [:create, :update, :destroy]
  resources :posts do
    resources :likes, only: [:create, :destroy]
    resources :comments, only: [:create, :edit, :update, :destroy]
  end
  resources :users, only: [:index, :show, :edit, :update]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
