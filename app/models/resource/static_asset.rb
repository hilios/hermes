class Resource::StaticAsset
  include Mongoid::Document
  field :content_type,  :type => String
  field :body,          :type => String
  
  embedded_in :resource, :polymorphic => true
end
