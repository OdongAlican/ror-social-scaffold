require 'rails_helper'
RSpec.describe FriendRequestsController, type: :controller do
  include Devise::Test::ControllerHelpers
  before(:each) do
    @user = FactoryBot.create(:user)
    @friend = FactoryBot.create(:user, name: 'John Doe', email: 'doe@example.com')
    sign_in @user
  end

  describe 'friendship features ' do
    it 'creates a friend request' do
      post :send_invitation, params: { user_id: @friend.id }
      expect(response).to redirect_to(users_path)
      expect(response).to have_http_status(302)
    end

    it 'accepts a friend request' do
      post :send_invitation, params: { user_id: @friend.id }
      sign_out @user
      sign_in @friend
      post :accept_invitation, params: { user_id: @user.id }
      expect(response).to redirect_to(users_path)
      expect(response).to have_http_status(302)
    end

    it 'rejects a friend request' do
      post :send_invitation, params: { user_id: @friend.id }
      sign_out @user
      sign_in @friend
      post :reject_invitation, params: { user_id: @user.id }
      expect(response).to redirect_to(users_path)
      expect(response).to have_http_status(302)
    end

    it 'unfriends an already friend' do
      post :send_invitation, params: { user_id: @friend.id }
      sign_out @user
      sign_in @friend
      post :accept_invitation, params: { user_id: @user.id }
      post :destroy, params: { user_id: @user.id, friend_id: @friend.id }
      expect(response).to redirect_to(users_path)
    end
  end
end
