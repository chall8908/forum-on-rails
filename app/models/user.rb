class User < ActiveRecord::Base
  attr_accessible :name, :password
  attr_protected :salt, :rank
  
  validates :name,  :presence => true,
                    :length => {:minimum => 3, :maximum => 25}
  
  validates :password,  :presence => true
  
  after_create :set_rank
  before_save :encrypt_password
  
  @@user_ranks = {:super => 0, :admin => 1, :regular => 2}
  
  def self.find_user(name, pass)
    user = User.where(:name => name).first
    return user if user and user.has_password? pass
    raise BadUsernameOrPasswordError.new "Incorrect username or password"
  end
  
  def has_permission?(permission)
    @@user_ranks[permission] >= @@user_rank[rank]
  end
  
  def has_password?(pass)
    EncryptedPassword.new(pass, salt).to_s == password
  end
  
  private
  
  def set_rank
    rank = :regular
  end
  
  def encrypt_password
    if password_changed?
      
      raise PasswordTooShortError.new unless password.length > 2
      
      password = EncryptedPassword.new(password)
      salt = password.salt
    end
  end
end
