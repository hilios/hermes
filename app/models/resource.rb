class Resource
  include Mongoid::Document
  include Mongoid::Versioning
  include Mongoid::Timestamps
  field :is_public,     :type => Boolean
  field :uri,           :type => String
  
  include Mongoid::Ancestry
  has_ancestry
  
  embeds_one :asset, :class_name => "Asset::Base", :cascade_callbacks => true
  accepts_nested_attributes_for :asset

  before_save :generate_uri

  def url
     "#{url}#{urn}"
  end
  
  def generate_uri
    # TODO: Loop through all parents and build path
  end
end
