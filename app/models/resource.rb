class Resource
  include Mongoid::Document
  include Mongoid::Versioning
  include Mongoid::Timestamps
  include Mongoid::Ancestry

  field :path, type: String
  
  has_ancestry

  belongs_to :website
  
  embeds_one :asset, 
    cascade_callbacks: true,
    class_name: Asset::Base.name

  accepts_nested_attributes_for :asset, 
    reject_if: ->(attributes) { attributes[:_type].blank? }

  delegate :name, 
    to: :asset

  attr_protected :path

  validates :path,
    presence: true,
    uniqueness: true

  validates :asset,
    presence: true

  validates :website,
    presence: true

  # Ensure the path is generated
  before_validation :generate_path

  # Scopes
  scope :folders, where(:'asset._type' => Asset::Folder.name)
  scope :from, ->(website) { where(website_id: website.is_a?(Website) ? website.id : website)  }

  # Returns an array with the values of this resource ready to use as a collection
  def self.to_collection
    all.map { |resource| [resource.asset.name, resource.id] }
  end

  # Overrides the ancestry method and return the self path
  def path
    self[:path]
  end

  # Returns the full path with the localization of this resource,
  # the URL is the parents URI with a slash at the end.
  def generate_path
    self[:path] = "#{parent.path unless is_root?}/#{name}"
  end

  # Returns true if this resource asset is a folder
  def folder?
    asset.is_a? Asset::Folder
  end

  def respond_to_domain?(domain)
    # TODO: Check domain
    raise "TODO: Check website domains"
  end

  # Returns an array with all asset classes avaliable
  # on this module besides Base
  def self.assets
    @_assets ||= Asset.constants.map do |class_name|
      Asset.const_get(class_name)
    end.reject do |klass|
      klass == Asset::Base
    end
  end
end
