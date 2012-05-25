module Asset
  class Static < Base
    field :content_type,  :type => String
    field :content,       :type => String

    mount_uploader :content, AssetUploader

    validates :content,
      :presence => true,
      :integrity => true

    validates_presence_of :content_type

    before_validation :set_content_info
    
    # When setting the content assign the URN with uploaded 
    # file name and content type.
    def set_content_info
      self[:content_type] ||= content.set_content_type.to_s
      self[:urn]          ||= content.send(:original_filename)
    end
  end
end