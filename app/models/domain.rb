class Domain
  include Mongoid::Document
  belongs_to :website

  field :url,             :type => String
  field :default_params,  :type => Hash

  validates :url,
    :url => true,
    :presence => true
end
