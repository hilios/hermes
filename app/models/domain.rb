class Domain
  include Mongoid::Document
  field :url,             :type => String
  field :default_params,  :type => Hash
  
  belongs_to :website

  validates :url,
    :url => true,
    :presence => true,
    :uniqueness => {:case_sensitive => false}
    
  def url
    super() or "http://"
  end
end
