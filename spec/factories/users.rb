FactoryGirl.define do
  factory :user do
    sequence(:user_name) { |n| "user#{n}" }
    password 'password'

    factory :admin_user do
      role 'admin'
    end
  end
end
