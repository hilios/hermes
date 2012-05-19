module Asset
  class Static < Base
    field :content_type,  :type => String
    field :body,          :type => Object

    mount_uploader :body  
  end
end