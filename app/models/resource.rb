class Resource
  include Mongoid::Document
  include Mongoid::Versioning
  include Mongoid::Timestamps
  field :uri,           :type => String
  
  include Mongoid::Ancestry
  has_ancestry

  belongs_to :website
  
  embeds_one :asset, 
    :cascade_callbacks => true,
    :class_name => "Asset::Base"

  accepts_nested_attributes_for :asset, 
    :reject_if => proc { |attributes| attributes['_type'].blank? }

  delegate :urn, :to => :asset

  validates_presence_of :uri, :asset, :website

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

  private :uri=
end
