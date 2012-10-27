class User < ActiveRecord::Base
  attr_accessible :name, :rank
  attr_protected :password
  
  before_save :encrypt_password
  
  def self.find_user(name, password)
    User.where(:name => name, :password => encrypt(password)).first
  end
  
  private
  def encrypt_password
    if password.changed?
      salt = Time.now
      password = encrypt("#{salt}-+-#{password})
  end
end
