class Domain
  include Mongoid::Document
  field :url,             :type => String
  field :default_params,  :type => Hash
  
  belongs_to :website

  validates :url,
    :url => true,
    :presence => true,
    :uniqueness => {:case_sensitive => false}
  
  def self.find(uri)
    uri = URI.parse(uri)
    # Try to guess the wildcard for search
    hosts = [uri.host]
    hosts << "*.#{uri.host.dup}"
    hosts << uri.host.dup.sub(/^[^\.]+/, '*')
    hosts.map { |host| Regexp.escape(uri.host) }
    # Build the search regexp
    uri = /^#{uri.scheme}\:\/\/(#{Regexp.union(hosts)})(\:#{uri.port})?$/
    where(:url => uri).limit(1).first
  end
    
  def url
    super() or "http://"
  end
  
  def to_s #:nodoc:
    url
  end
end
