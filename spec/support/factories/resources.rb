# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :resource, aliases: [:folder] do

    asset { FactoryGirl.build(:asset_folder) }

    factory(:image) do
      
    end
  end

  sequence(:urn) { |n| "resource#{n}" }

  factory :asset_folder, class: Asset::Folder do
    _type Asset::Folder.name
    urn
  end
end