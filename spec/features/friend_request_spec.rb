require 'rails_helper'

RSpec.describe 'friend request', type: :feature do
  let(:user) { User.create(name: 'John', email: 'john@example.com', password: '12345678') }

  scenario 'send a friend request' do
    user = FactoryBot.create(:user)
    friend = FactoryBot.create(:user, name: 'John', email: 'john@example.com')
    visit root_url
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_button 'Log in'
    expect(page).to have_content('Signed in successfully')
    expect(page).to have_content('Recent posts')
    visit users_path
    expect(page).to have_content('Name')
    click_on 'Add Friend'
    expect(page).to have_content('Friend invitation sent')
  end

  scenario 'Accept a friend request' do
    user = FactoryBot.create(:user)
    friend = FactoryBot.create(:user, name: 'John', email: 'john@example.com', password: '1234567', password_confirmation: '1234567')
    visit root_url
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_button 'Log in'
    expect(page).to have_content('Signed in successfully')
    expect(page).to have_content('Recent posts')
    visit users_path
    expect(page).to have_content('Name')
    click_on 'Add Friend'
    click_on 'Sign out'
    visit root_url
    fill_in 'Email', with: friend.email
    fill_in 'Password', with: friend.password
    click_button 'Log in'
    visit users_path
    click_on 'Accept'
    expect(page).to have_content('friend accepted')
  end

  scenario 'Decline a friend request' do
    user = FactoryBot.create(:user)
    friend = FactoryBot.create(:user, name: 'John', email: 'john@example.com', password: '1234567', password_confirmation: '1234567')
    visit root_url
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_button 'Log in'
    expect(page).to have_content('Signed in successfully')
    expect(page).to have_content('Recent posts')
    visit users_path
    expect(page).to have_content('Name')
    click_on 'Add Friend'
    click_on 'Sign out'
    visit root_url
    fill_in 'Email', with: friend.email
    fill_in 'Password', with: friend.password
    click_button 'Log in'
    visit users_path
    click_on 'Decline'
    expect(page).to have_content('friend request declined')
  end
end
