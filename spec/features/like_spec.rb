require 'rails_helper'
RSpec.describe 'Like', type: :feature do
  before(:each) do
    user = FactoryBot.create(:user)
    visit root_url
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_button 'Log in'
  end

  scenario 'creating valid comment' do
    post = FactoryBot.create(:post)
    visit posts_path
    click_on 'Like!'
    expect(page).to have_content('Dislike!')
  end
end
