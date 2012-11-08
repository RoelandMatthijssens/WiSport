class Information < ActiveRecord::Base
  attr_accessible :description, :media, :images_attributes

  belongs_to :exercise
  has_many :images
  
  accepts_nested_attributes_for :images, allow_destroy: true
end
