FactoryBot.define do
  factory :user do
    sequence(:email) { |n| "user#{n}@example.com" }
    password { "password" }
    association :role
    
    trait :admin do
      role { Role.find_by(name: "admin") || create(:role, :admin) }
    end

    trait :subadmin do
      role { Role.find_by(name: "subadmin") || create(:role, :subadmin) }
    end
    
    trait :visitor do
      role { Role.find_by(name: "visitor") || create(:role, :visitor) }
    end

    trait :insider do
      role { Role.find_by(name: "insider") || create(:role, :insider) }
    end
  end
end
