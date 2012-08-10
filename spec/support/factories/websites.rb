# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :website do
    name            { Forgery(:name).company_name }
    domains         { FactoryGirl.create_list(:domain, 2) }
  end

  factory :domain do
    url             { "http://#{Forgery(:internet).domain_name}" }
  end
end
