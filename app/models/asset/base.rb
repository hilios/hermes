module Asset
  class Base
    include Mongoid::Document
    field :urn, :type => String
    embedded_in :resource
  end
end