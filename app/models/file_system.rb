class FileSystem
  include Mongoid::Document
  field :url, :type => String
  
  include Mongoid::Ancestry
  has_ancestry
end
