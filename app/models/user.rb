require 'digest/sha1'
class User < ActiveRecord::Base
  attr_accessible :name, :rank, :password
  
  before_save :encrypt_password
  
  @@user_ranks = {:super => 0, :admin => 1, :regular => 2}
  
  def self.find_user(name, pass)
    user = User.where(:name => name);
    return user if encrypt(user.salt, pass) == password
    nil
  end
  
  def self.make_user(name, pass)
    user = User.new({:name => name})
    user.password = pass
    user.rank = :regular
  end
  
  def has_permission(permission)
    @@user_ranks[permission] => @@user_rank[rank]
  end
  
  private
  def encrypt_password
    if password.changed?
      salt = Time.now
      password = encrypt(salt, password)
    end
  end
  
  def encrypt(salt, pass)
    Digest::SHA1.hexdigest "#{salt}-+-#{pass}"
  end
end
