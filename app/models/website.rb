class Website
  include Mongoid::Document
  field :name,            :type => String
  field :default_params,  :type => Hash

  has_many :domains, 
    :autosave => true,
    :dependent => :destroy
  accepts_nested_attributes_for :domains, 
    :allow_destroy => true, :reject_if => proc { |domain| domain['url'] == "http://" }
    
  validates_presence_of :name
  
  validate :require_one_domain_at_least
  
  def require_one_domain_at_least
    errors[:domain] << :empty if domains.empty?
  end
  
  def urls
    domains.map(&:url)
  end
end
