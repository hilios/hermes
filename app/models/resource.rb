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
  # Custom validations
  scope :folders, where(:'asset._type' => Asset::Folder.name)
  scope :from, lambda { |website| where(:website_id => website.is_a?(Website) ? website.id : website)  }
  # Returns an array with the values of this resource ready to use as a collection
  def self.to_collection
    all.map { |resource| [resource.asset.urn, resource.id] }
  end
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

  def respond_to_domain?(domain)
    # TODO: Check domain
    raise "TODO: Check website domains"
  end

  private :uri=
end
