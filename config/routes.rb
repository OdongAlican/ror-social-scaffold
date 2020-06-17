Rails.application.routes.draw do

  root 'posts#index'


  delete 'remove_friend' => 'friend_requests#destroy'
  get 'send_invite' => 'friend_requests#send_invitation'
  get 'accept_invite' => 'friend_requests#accept_invitation'
  get 'pending_invite' => 'friend_requests#pending_invitation'
  get 'friends_list' => 'friend_requests#friends_list'
  delete 'reject_invite' => 'friend_requests#reject_invitation'

  devise_for :users
  resources :users, only: [:index, :show]
  resources :friend_requests
  resources :posts, only: [:index, :create] do
    resources :comments, only: [:create]
    resources :likes, only: [:create, :destroy]
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
