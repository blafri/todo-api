FactoryGirl.define do
  factory :user do
    sequence(:user_name) { |n| "user#{n}" }
    password 'password'
  end
end
