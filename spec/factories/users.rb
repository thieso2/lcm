FactoryGirl.define do
  factory :user do
    email     "user@example.com"
    password  "please123"

    trait :admin do
      access 'admin'
    end

  end
end
