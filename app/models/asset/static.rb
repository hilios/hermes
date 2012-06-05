module Asset
  class Static < Base
    field :content,       :type => String

    mount_uploader :content, AssetUploader

    validates :content,
      :presence => true,
      :integrity => true,
      :on => :create
      
    before_validation :set_urn
      
    # When setting the content assign the URN with uploaded 
    # file name and content type.
    def set_urn
      self[:urn] = content.send(:original_filename) if self[:urn].blank?
    end

    def file(&block)
      Mongo::GridFileSystem.new(Mongoid.database).open(content.url, 'r', &block)
    end
  end
end