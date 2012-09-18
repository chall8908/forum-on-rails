class Post < ActiveRecord::Base
  has_one :user
  belongs_to :thread
  attr_accessible :body, :status, :visible
end
