class Resource
  include Mongoid::Document
  include Mongoid::Versioning
  include Mongoid::Timestamps
  field :uri,           :type => String
  
  include Mongoid::Ancestry
  has_ancestry
  
  embeds_one :asset, :class_name => "Asset::Base", :cascade_callbacks => true
  accepts_nested_attributes_for :asset

  delegate :urn, :to => :asset

  validates_presence_of :uri, :asset

  attr_protected :uri
  # Ensure the URI is generated
  before_save :uri
  # Returns the full path with the localization of this resource,
  # the URL is the parents URI with a slash at the end.
  def url
    "#{parent.uri unless is_root?}/"
  end
  # Returns the uri for this resource
  # URI = URL + URN
  def uri
    self[:uri] = "#{url}#{urn}"
  end
  # Returns true if this resource asset is a folder
  def folder?
    asset.is_a? Asset::Folder
  end
end
