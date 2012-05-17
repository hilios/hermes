class Resource
  include Mongoid::Document
  include Mongoid::Versioning
  include Mongoid::Timestamps::Created
  include Mongoid::Timestamps::Updated
  field :is_public,     :type => Boolean
  # URN => Uniform Resource Name
  field :urn,           :type => String
  # URI => Uniform Resource Identifier
  field :uri,           :type => String
  
  include Mongoid::Ancestry
  has_ancestry
  
  embeds_one :static_asset, :as => :asset

  before_save :generate_uri

  def url
     "#{url}#{urn}"
  end
  
  def generate_uri
    # TODO: Loop through all parents and build path
  end
end
