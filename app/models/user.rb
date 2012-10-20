class User < ActiveRecord::Base
  has_many :posts, :ranks
  
  attr_accessible :email, :im_services, :name, :primary_rank, :signature, :title
end
