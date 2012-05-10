class User
  include Mongoid::Document
  # Devise modules
  devise :database_authenticatable, :recoverable, :encryptable, :trackable, :rememberable
  # Collection map
  field :name,      :type => String
  field :role,      :type => String
  field :is_active, :type => Boolean, :null => false, :default => true
  # Database authenticatable
  field :email,              :type => String, :null => false, :default => ""
  field :encrypted_password, :type => String, :null => false, :default => ""
  # Recoverable
  field :reset_password_token,   :type => String
  field :reset_password_sent_at, :type => Time
  # Trackable
  field :sign_in_count,      :type => Integer, :default => 0
  field :current_sign_in_at, :type => Time
  field :last_sign_in_at,    :type => Time
  field :current_sign_in_ip, :type => String
  field :last_sign_in_ip,    :type => String
  # Encryptable
  field :password_salt, :type => String
  # Rememberable
  field :remember_created_at, :type => Time

  # Validations
  validates :name, 
    :presence => true

  validates :email,
    :email => true,
    :presence => true,
    :uniqueness => {:case_sensitive => false}

  validates :role,
    :presence => true
    
  def is?(role_name)
    role_name.to_sym == role.to_sym
  end
end
