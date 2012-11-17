class User < ActiveRecord::Base
  attr_accessible :name, :password
  attr_protected :salt, :rank

  validates :name,  :presence => true,
                    :length => {:minimum => 3, :maximum => 25},
                    :uniqueness => {:case_sensitive => false}

  validates_each :password do |record, attr, value|
    if record.password_changed? || record.id.nil?
      record.password = EncryptedPassword.new(value)
      record.salt = record.password.salt
    end
  end

  before_create :set_rank

  @@user_ranks = {:super => 0, :admin => 1, :regular => 2}

  def self.find_user(name, pass)
    user = User.where(:name => name).first
    return user if user and user.has_password? pass
    raise BadUsernameOrPasswordError.new "Incorrect username or password"
  end

  def has_permission?(permission)
    @@user_ranks[permission] >= @@user_ranks[rank.to_sym]
  end

  def has_password?(pass)
    EncryptedPassword.new(pass, salt).to_s == password
  end

  private

  def set_rank
    self.rank = "regular"
  end
end
