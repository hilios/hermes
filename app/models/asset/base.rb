module Asset
  class Base
    include Mongoid::Document
    field :urn, :type => String
    
    embedded_in :resource
    
    validates_presence_of :urn
  end
end