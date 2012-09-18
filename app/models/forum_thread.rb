class ForumThread < ActiveRecord::Base
  has_many :posts
  attr_accessible :first_post, :title
end
