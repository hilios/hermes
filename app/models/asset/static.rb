module Asset
  class Static < Base
    field :content_type,  :type => String
    # field :body,          :type => String

    mount_uploader :body, AssetUploader
  end
end