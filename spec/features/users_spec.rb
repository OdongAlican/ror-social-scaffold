require 'rails_helper'

RSpec.describe 'authenticate a user', type: :feature do
  let(:user) { User.create(name: 'John', email: 'john@example.com', password: '12345678') }

  scenario 'sign up a user' do
    user = FactoryBot.create(:user)
    visit new_user_registration_path
    fill_in 'Name', with: user.name
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    fill_in 'Password confirmation', with: user.password_confirmation
    click_button 'Sign up'
  end

  scenario "login a user" do
    user = FactoryBot.create(:user)
    visit root_url
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_button 'Log in'
    expect(page).to have_content("Signed in successfully")
    expect(page).to have_content("Recent posts") 
  end

  scenario 'logout a user' do
    user = FactoryBot.create(:user)
    visit root_url
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_button 'Log in'
    click_on 'Sign out'
    expect(page).to have_content('Email')
    expect(page).to have_content('Sign up')
  
  end
end
