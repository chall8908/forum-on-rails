class Rank < ActiveRecord::Base
  belongs_to_many :users
  
  attr_accessible :color, :custom, :image, :min_posts, :name, :permissions
end
