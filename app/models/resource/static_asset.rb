class Resource::StaticAsset
  include Mongoid::Document
  field :content_type,  :type => String
  field :body,          :type => String

  mount_uploader :body
  
  embedded_in :asset, :polymorphic => true
end