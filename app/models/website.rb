class Website
  include Mongoid::Document
  field :name,            :type => String
  field :default_params,  :type => Hash

  has_many :resources,
    :dependent => :destroy

  has_many :domains, 
    :autosave => true,
    :dependent => :destroy
    
  accepts_nested_attributes_for :domains, 
    :allow_destroy => true, :reject_if => proc { |domain| domain['url'] == "http://" }
    
  validates_presence_of :name
  
  validate :at_least_one_domain
  
  def at_least_one_domain
    errors[:domain] << :empty if domains.empty?
  end
  
  def urls
    domains.map(&:url)
  end
end
