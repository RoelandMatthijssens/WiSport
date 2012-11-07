class Information < ActiveRecord::Base
  attr_accessible :description, :media

  belongs_to :exercise
  has_many :images
end
