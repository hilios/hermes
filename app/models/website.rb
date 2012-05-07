class Website
  include Mongoid::Document
  field :name,            :type => String
  field :default_params,  :type => Hash

  has_many :domains, 
    :dependent => :destroy
  accepts_nested_attributes_for :domains

  validates_presence_of :name
end
