module Asset
  class Static < Base
    field :content,       :type => String

    mount_uploader :content, AssetUploader

    validates :content,
      :presence => true,
      :integrity => true,
      :on => :create
      
    before_validation :set_name
      
    # When setting the content assign the URN with uploaded 
    # file name and content type.
    def set_name
      self[:name] = content.send(:original_filename) if self[:name].blank?
    end

    def file(&block)
      Mongo::GridFileSystem.new(Mongoid.database).open(content.path, 'r', &block)
    end
  end
end