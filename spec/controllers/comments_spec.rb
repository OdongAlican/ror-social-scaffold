require 'rails_helper'

RSpec.describe CommentsController, type: :controller do
  include Devise::Test::ControllerHelpers
  before(:each) do
    @user = FactoryBot.create(:user)
    sign_in @user
    @post = @user.posts.create!(content: 'Sample post')
  end

  describe 'creating comments' do
    it 'creates a new post with valid params' do
      post :create, params: { post_id: @post.id, user_id: @user.id, comment: { content: 'comment test' } }
      expect(response).to redirect_to(posts_path)
      expect(flash[:notice]).to eql('Comment was successfully created.')
    end

    it 'renders new template with invalid params' do
      post :create, params: { post_id: @post.id, user_id: @user.id, comment: { content: '' } }
      expect(response).to redirect_to(posts_path)
      expect(response).to have_http_status(302)
      expect(flash[:alert]).to eql("Content can't be blank")
    end
  end
end
