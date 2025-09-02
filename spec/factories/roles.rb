FactoryBot.define do
  factory :role do
    sequence(:name) { |n| "role_#{n}" }

    trait :visitor do
      name { "visitor" }
    end

    trait :insider do
      name { "insider" }
    end

    trait :admin do
      name { "admin" }
    end

    trait :subadmin do
      name { "subadmin" }
    end
  end
end
