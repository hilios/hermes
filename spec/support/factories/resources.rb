# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :resource, aliases: [:folder] do
    website
    asset { FactoryGirl.build(:asset_folder) }

    factory :image, class: Resource do
      asset { FactoryGirl.build(:asset_static, content: upload(:jpg)) }
    end

    factory :pdf, class: Resource do
      asset { FactoryGirl.build(:asset_static, content: upload(:pdf)) }
    end
  end
  
  factory :asset_folder, class: Asset::Folder do
    _type Asset::Folder.name
    sequence(:name) { |n| "resource#{n}" }
  end

  factory :asset_static, class: Asset::Static do
    _type Asset::Static.name
  end
end