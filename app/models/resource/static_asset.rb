class Resource::StaticAsset
  include Mongoid::Document
  field :content_type,  :type => String
  field :body,          :type => Object

  mount_uploader :body
  
  embedded_in :resource, :polymorphic => true
end
