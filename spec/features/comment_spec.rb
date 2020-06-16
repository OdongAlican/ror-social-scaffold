require 'rails_helper'
RSpec.describe 'Comment', type: :feature do
  before(:each) do
    user = FactoryBot.create(:user)
    visit root_url
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_button 'Log in'
  end

  scenario 'creating valid comment' do
    post = FactoryBot.create(:post)
    comment = FactoryBot.create(:comment)
    visit posts_path
    fill_in 'comment_content', with: comment.content
    click_button 'Comment'
    expect(page).to have_content('Comment was successfully created.')
  end
end
