FactoryBot.define do
  factory :room_message do
    message { Faker::Lorem.sentence }
    association :user
    association :room
  end
end
