# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :website do
    sequence(:name) { |n| "Website #{n}" }
    domains         { FactoryGirl.create_list(:domain, 2) }
  end

  factory :domain do
    sequence(:url)  { |n| "http://www.host#{n}.com" }
  end
end
