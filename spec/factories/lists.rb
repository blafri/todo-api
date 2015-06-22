FactoryGirl.define do
  factory :list do
    user
    sequence(:name) { |n| "list #{n}" }
  end
end
