class Resource
  include Mongoid::Document
  # URN = Uniform Resouce Name
  field :urn,           :type => String
  
  include Mongoid::Ancestry
  has_ancestry

  def uri
    "#{url}#{urn}"
  end

  def url
    "http://"
  end
end
