class Rank < ActiveRecord::Base
  belongs_to_many :users
  has_many :permissions
  attr_accessible :color, :custom, :image, :min_posts, :name
end
