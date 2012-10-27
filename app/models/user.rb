require 'digest/sha1'
class User < ActiveRecord::Base
  attr_accessible :name, :password
  attr_protected :salt, :rank
  
  validates :name,  :presence => true,
                    :length => {:minimum => 3, :maximum => 25}
  
  validates :password,  :presence => true
  
  before_save :encrypt_password
  
  @@user_ranks = {:super => 0, :admin => 1, :regular => 2}
  
  def self.find_user(name, pass)
    user = User.where(:name => name).first
    return user if user and has_password? pass
  end
  
  def self.create!(params)
    user = User.new({:name => params[:name]})
    user.password = params[:pass]
    user.rank = :regular
    user.save
  end
  
  def has_permission(permission)
    @@user_ranks[permission] >= @@user_rank[rank]
  end
  
  def has_password?(pass)
    self.encrypt(salt, pass) == password
  end
  
  private
  def encrypt_password
    if password_changed?
      
      raise PasswordTooShortException.new unless password.length > 2
      
      self.salt = encrypt(Time.now, password)
      self.password = encrypt(salt, password)
    end
  end
  
  def self.encrypt(salt, pass)
    Digest::SHA1.hexdigest "#{salt}-+-#{pass}"
  end
end
