require 'digest/sha1'

class EncryptedPassword < String
  
  attr_accessor :salt, :password
  
  def initialize(password, salt = nil)
    @salt = salt || encrypt(password, Time.now)
    super encrypt(password, salt)
  end
  
  private
  def encrypt(password, salt = "")
    Digest::SHA1.hexdigest "#{salt}-+-#{password}"
  end
end