Rails.application.routes.draw do

  root 'posts#index'

  devise_for :users

  resources :users, only: [:index, :show]
  resources :friend_requests, only: [:new, :create, :destroy, :show]
  resources :posts, only: [:index, :create] do
    resources :comments, only: [:create]
    resources :likes, only: [:create, :destroy]
  end

  post '/accept' => 'friend_requests#accept'
  post '/reject' => 'friend_requests#reject'
  post '/cancel' => 'friend_requests#cancel'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
