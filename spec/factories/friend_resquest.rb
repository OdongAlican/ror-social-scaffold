FactoryBot.define do
  factory :friend_request do
    friend_id { User.last.id }
    user_id { User.first.id }
    confirmed { true }
  end
end
