class User < ActiveRecord::Base
  include ActiveModel::ForbiddenAttributesProtection
  
  attr_protected :salt

  validates :name,  :presence   => true,
                    :length     => {:minimum => 3, :maximum => 25},
                    :uniqueness => {:case_sensitive => false}

  validates_each :password do |record, attr, value|
    if record.password_changed? || record.id.nil?

      raise PasswordTooShortError.new "Your password must be, at least, 4 characters." unless value.length > 4

      record.password = EncryptedPassword.new(value)
      record.salt = record.password.salt
    end
  end

  validates :email, :presence   => true,
                    :uniqueness => {:case_sensitive => false}

# Class Methods
  def self.find_user(name, pass)
    user = User.where(:name => name).first
    return user if user and user.has_password? pass
    raise BadUsernameOrPasswordError.new "Incorrect username or password"
  end

# Instance Methods
  def has_password?(pass)
    EncryptedPassword.new(pass, salt) == password
  end

  def custom_avatar_url
    ""
  end

  def to_s
    name
  end
end
