class Role
  attr_reader :name
  
  def initialize(name)
    @name = name
  end
  
  def to_s
    name
  end
  
  def to_sym
    name.to_sym
  end
  
  def self.all
    @all ||= MoulinRouge::Authorization.roles
  end
  
  def self.find(sym)
    index = MoulinRouge::Authorization.roles.index(sym)
    raise Role::NotFound if index.nil?
    Role.new(MoulinRouge::Authorization.roles[index])
  end
  
  class NotFound < Exception; end
end
