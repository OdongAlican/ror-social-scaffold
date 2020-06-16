require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { User.create(name: 'john', email: 'johndoe@example.com') }
  let(:user1) do
    User.create(name: 'Foobar', email: 'foobar@gmail.com',
                password: 'foobar', password_confirmation: 'foobar')
  end
  let(:friend) do
    User.create(name: 'Footbar', email: 'footbar@gmail.com',
                password: 'foobar', password_confirmation: 'foobar')
  end
  let(:friend_request) { FriendRequest.create(user_id: user1.id, friend_id: friend.id, confirmed: false) }

  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_length_of(:name).is_at_most(20) }
    it { should validate_presence_of(:email) }
    it { should validate_uniqueness_of(:email).case_insensitive }
    it { should allow_value('test@test.com').for(:email) }
    it { should_not allow_value('test@test').for(:email) }
  end

  describe 'associations' do
    it { should have_many(:posts) }
    it { should have_many(:comments) }
    it { should have_many(:likes) }
    it { should have_many(:friend_requests) }
    it { should have_many(:inverse_friend_requests).class_name('FriendRequest').with_foreign_key(:friend_id) }
  end

  describe 'validates friendship associations' do
    it 'validates if friend is friends' do
      expect(user1.friends).to_not include(friend)
    end
  end
end
