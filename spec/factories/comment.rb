FactoryBot.define do
  factory :comment do
    content { 'Looking for it' }
    user_id { User.first.id }
    post_id { Post.first.id }
  end
end
