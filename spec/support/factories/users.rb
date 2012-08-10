# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    name            { Forgery(:name).full_name }
    email           { Forgery(:email).address }
    password        { Forgery(:basic).password(at_least: 8) }
    role            :webmaster
    websites        { FactoryGirl.create_list(:website, 1) }
    
    factory(:admin)        { role :admin }
    factory(:webmaster)    { role :webmaster }
    factory(:webdesigner)  { role :webdesigner }
    factory(:copywriter)   { role :copywriter }
  end
end
