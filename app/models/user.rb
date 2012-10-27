require 'digest/sha1'
class User < ActiveRecord::Base
  attr_accessible :name, :rank, :password
  
  before_save :encrypt_password
  
  def self.find_user(name, pass)
    user = User.where(:name => name);
    return user if encrypt(user.salt, pass) == password
    nil
  end
  
  private
  def encrypt_password
    if password.changed?
      salt = Time.now
      password = encrypt(salt, password)
  end
  
  def encrypt(salt, pass)
    Digest::SHA1.hexdigest "#{salt}-+-#{pass}"
  end
end
