class Board < ActiveRecord::Base
  has_many :threads
  
  attr_accessible :description, :name
end
