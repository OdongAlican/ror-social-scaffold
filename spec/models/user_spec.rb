require 'rails_helper'
RSpec.describe User, type: :model do
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
  describe 'user class methods' do
    before(:each) do
      @user1 = FactoryBot.create(:user, name: 'Sunday', email: 'sunday@example.com')
      @user2 = FactoryBot.create(:user, name: 'john', email: 'johnd@example.com')
      @friend = FactoryBot.create(:user, name: 'Phyl', email: 'phyl@example.com')
      @friend_request1 = FactoryBot.create(:friend_request, user_id: @user1.id, friend_id: @friend.id, confirmed: false)
      @friend_request2 = FactoryBot.create(:friend_request, user_id: @user2.id, friend_id: @friend.id, confirmed: true)
    end

    it 'checks if friend sending invitaion' do
      expect(@user2.send_invitation(@friend.id)).to eql(true)
      expect(@friend_request1.confirmed).to eql(false)
    end

    it 'checks for pending invitaion' do
      @user1.send_invitation(@friend.id)
      expect(@user1.pending_invites).to include(@friend)
      expect(@friend_request1.confirmed).not_to eql(true)
    end

    it 'checks for pending friends' do
      @friend.send_invitation(@user1.id)
      expect(@user1.pending_friends).to include(@friend)
    end

    it 'checks for confirming invitaion' do
      @friend.send_invitation(@user2.id)
      expect(@friend.confirm_invites(@user2.id)).to be(true)
      expect(@friend_request2.confirmed).to eql(true)
    end

    it 'checks for receive invitaion' do
      @friend.send_invitation(@user1.id)
      expect(@user1.receive_invitation(@friend.id)).to be(true)
      expect(@friend_request1.confirmed).to eql(false)
    end

    it 'checks for friends invited' do
      @friend.send_invitation(@user1.id)
      expect(@friend.friend_invites(@user1.id)).to be(true)
      expect(@friend_request1.confirmed).to eql(false)
    end

    it 'checks for rejecting invitaion' do
      @user1.send_invitation(@friend.id)
      @friend.reject_invites(@user1.id)
      expect(@user1.friends).not_to include(@friend)
    end

    it 'confirms if a user is a friend' do
      @user1.send_invitation(@friend.id)
      @user2.send_invitation(@friend.id)
      expect(@user1.friend?(@friend)).to be(false)
      expect(@user2.friend?(@friend)).to be(true)
    end

    it 'confirms if a user is among friends' do
      @user1.send_invitation(@friend.id)
      expect(@user1.friends).not_to include(@friend)
    end
  end
end
