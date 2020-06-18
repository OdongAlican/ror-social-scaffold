require 'rails_helper'
RSpec.describe LikesController, type: :controller do
  include Devise::Test::ControllerHelpers
  before(:each) do
    @user = FactoryBot.create(:user)
    sign_in @user
    @post = Post.create!(content: 'Sample test', user_id: @user.id)
  end

  describe 'liking and disliking a post' do
    it 'likes a post' do
      post :create, params: { post_id: @post.id, user_id: @user.id }
      expect(response).to redirect_to(posts_path)
      expect(flash[:notice]).to eql('You liked a post.')
    end

    it 'dislikes a post' do
      post :create, params: { post_id: @post.id, user_id: @user.id }
      expect(response).to redirect_to(posts_path)
      expect(flash[:notice]).to eql('You liked a post.')
      delete :destroy, params: { id: Like.all[0].id, post_id: @post.id, user_id: @user.id }
      expect(response).to redirect_to(posts_path)
      expect(flash[:notice]).to match('You disliked a post.')
    end
  end
end
