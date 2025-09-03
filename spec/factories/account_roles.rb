FactoryBot.define do
  factory :account_role do
    association :account
    association :user
    sequence(:name) { |n| "role_#{n}" }
  end
end
