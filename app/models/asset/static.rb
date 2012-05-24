module Asset
  class Static < Base
    # field :content,       :type => String

    mount_uploader :content, AssetUploader
    
    attr_accessible :content, :content_cache
    
    before_create :assign_urn
    
    def assign_urn
      self[:urn] = content.send(:original_filename)
    end
  end
end