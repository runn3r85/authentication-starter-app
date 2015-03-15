FactoryGirl.define do
  factory :user do
    first_name "Test"
    last_name "User"
    sequence :email do |n| 
      "user#{n}@example.com"
    end
    sequence(:username) { |n| "TestUser#{n}" }
    password "math1234"
    password_confirmation "math1234"
  end

end