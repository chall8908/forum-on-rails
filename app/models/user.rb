require 'digest/sha1'
class User < ActiveRecord::Base
  attr_accessible :name, :rank, :password
  attr_protected :salt
  
  validates :name,  :presence => true,
                    :length => {:minimum => 3, :maximum => 25}
  
  validates :password,  :presence => true,
                        :length => {:minimum => 3, :maximum => 25}
  
  before_save :encrypt_password
  
  @@user_ranks = {:super => 0, :admin => 1, :regular => 2}
  
  def self.find_user(name, pass)
    user = User.where(:name => name);
    return user if encrypt(user.salt, pass) == password
    nil
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
  
  private
  def encrypt_password
    if password_changed?
      self.salt = Time.now
      self.password = encrypt(salt, password)
    end
  end
  
  def encrypt(salt, pass)
    Digest::SHA1.hexdigest "#{salt}-+-#{pass}"
  end
end
