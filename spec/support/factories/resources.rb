# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :resource do
    sequence(:urn) { |n| "resource#{n}" }
  end
end
