# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    sequence(:name) { |n| "User #{n}" }
    email           { "#{name.underscore.gsub(/\s/, '_')}@host.com" }
    password        "abc123"
    role            :webmaster
    websites        { [FactoryGirl.create(:website)] }
    
    factory(:admin)        { role :admin }
    factory(:webmaster)    { role :webmaster }
    factory(:webdesigner)  { role :webdesigner }
    factory(:copywriter)   { role :copywriter }
  end
end
