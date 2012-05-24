module Asset
  class Static < Base
    field :content_type,  :type => String
    field :content,       :type => String

    mount_uploader :content, AssetUploader

    validates :content,
      :presence => true,
      :integrity => true
    
    # When setting the content assign the URN with uploaded 
    # file name and content type.
    def content=(value)
      super(value)
      self[:content_type] ||= content.set_content_type
      self[:urn]          ||= content.send(:original_filename)
    end
  end
end