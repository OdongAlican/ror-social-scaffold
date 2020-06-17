class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name, presence: true, length: { maximum: 20 }

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i.freeze
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: true

  has_many :posts
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :friend_requests
  has_many :inverse_friend_requests, class_name: 'FriendRequest', foreign_key: 'friend_id'

  def friends
    friends_array = friend_requests.map { |friendship| friendship.friend if friendship.confirmed }
    friends_array + inverse_friend_requests.map { |friendship| friendship.user if friendship.confirmed }
    friends_array.compact
  end

  def pending_friends
    friend_requests.map { |friendship| friendship.friend unless friendship.confirmed }.compact
  end

  def friend_requests
    inverse_friend_requests.map { |friendship| friendship.user unless friendship.confirmed }.compact
  end

  def confirm_friend(user)
    friendship = inverse_friend_requests.find { |friendship| friendship.user == user }
    friendship.confirmed = true
    friendship.save
  end

  def reject_friend(user)
    friendship = inverse_friend_requests.find { |ship| ship.user == user }
    friendship.destroy
  end

  def cancel_request(user)
    friendship = friend_requests.find { |ship| ship.friend == user }
    friendship.destroy
  end

  def friend?(user)
    friends.include?(user)
  end
end
