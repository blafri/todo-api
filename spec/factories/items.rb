FactoryGirl.define do
  factory :item do
    list
    sequence(:name) { |n| "item #{n}" }
  end
end