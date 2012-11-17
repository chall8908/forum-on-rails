require 'digest/sha1'

class EncryptedPassword < String

  attr_accessor :salt, :password

  def initialize(password, salt = nil)

    raise PasswordTooShortError.new("Password must be, at least, 3 characters long.") unless password.length > 2

    @salt = salt || encrypt(password, Time.now)
    super encrypt(password, @salt)
  end

  private
  def encrypt(password, salt = "")
    Digest::SHA1.hexdigest "#{salt}-+-#{password}"
  end
end
