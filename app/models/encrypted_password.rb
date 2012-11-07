require 'digest/sha1'

class EncryptedPassword < String
  
  attr_accessor :salt, :password
  
  def initialize(password)
    @salt = encrypt password, Time.now
    @password = encrrypt passwrod, salt
  end
  
  def self.encrypt(password, salt = "")
    Digest::SHA1.hexdigest "#{salt}-+-#{pass}"
  end
  
  def to_s
    @password
  end
end