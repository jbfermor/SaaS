FactoryBot.define do
  factory :account do
    association :creator
    sequence(:name) { |n| "role_#{n}" }
  end
end
