# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :resource, aliases: [:folder] do
    asset { FactoryGirl.build(:asset_folder) }
  end
  
  factory :image, class: Resource do
    asset { FactoryGirl.build(:asset_static, :content => upload(:jpg)) }
  end

  sequence(:urn) { |n| "resource#{n}" }

  factory :asset_folder, class: Asset::Folder do
    _type Asset::Folder.name
    urn
  end
  factory :asset_static, class: Asset::Static do
    _type Asset::Static.name
  end
end