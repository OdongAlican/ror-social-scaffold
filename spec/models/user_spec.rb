require 'rails_helper'

RSpec.describe User, type: :model do
let(:user) {User.create(name: "john", email: "johndoe@example.com")}

  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_length_of(:name).is_at_most(20) }
    it { should validate_presence_of(:email) }
    it { should validate_uniqueness_of(:email).case_insensitive } 
    it { should allow_value('test@test.com').for(:email) }
    it { should_not allow_value('test@test').for(:email) }
  end

  describe 'associations' do
    it { should have_many(:posts)}
    it { should have_many(:comments)}
    it { should have_many(:likes)}
    it { should have_many(:friend_requests)}
    it { should have_many(:inverse_friend_requests).class_name("FriendRequest").with_foreign_key(:friend_id) }
  end
end
