FactoryBot.define do
  factory :post do
    content { 'Location is not given yet' }
    user_id { User.first.id }
  end
end
