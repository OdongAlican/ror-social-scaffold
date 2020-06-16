require 'rails_helper'
RSpec.describe 'Post', type: :feature do
  let(:user) { User.create(name: 'John', email: 'john@example.com') }

  before(:each) do
    user = FactoryBot.create(:user)
    visit root_url
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_button 'Log in'
  end

  scenario 'show all posts' do
    visit posts_path
    expect(page).to have_content('Recent posts')
  end

  scenario 'creating valid posts' do
    post = FactoryBot.create(:post)
    visit posts_path
    fill_in 'post_content', with: post.content
    click_button 'Save'
    expect(page).to have_content('Post was successfully created.')
  end
end
