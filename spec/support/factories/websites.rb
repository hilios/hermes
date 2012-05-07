# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :website do
    sequence(:name) { |n| "Website #{n}" }
    # domain
  end

  factory :domain do
    sequence(:name) { |n| "http://www.host#{n}.com" }
  end
end
