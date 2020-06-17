class FriendRequestsController < ApplicationController
    def create
      @friend_request = current_user.friend_requests.build(friend_id: params[:user_id])
      @friend_request.save
      redirect_to users_path
    end
  
    def accept
      current_user.confirm_friend(User.find_by(id: params[:user_id]))
      redirect_to users_path
    end
  
    def reject
      current_user.reject_friend(User.find_by(id: params[:user_id]))
      redirect_to users_path
    end
  
    def cancel
      current_user.cancel_request(User.find_by(id: params[:user_id]))
      redirect_to users_path
    end
  
    def destroy
      f1 = FriendRequest.all.find_by(user_id: params[:user_id], friend_id: current_user.id)
      f2 = FriendRequest.all.find_by(user_id: current_user.id, friend_id: params[:user_id])
      f1&.destroy
      f2&.destroy
      redirect_to users_path
    end
  end
  