class Information < ActiveRecord::Base
  attr_accessible :description, :images_attributes, :image_ids

  belongs_to :exercise
  has_many :images
  
  accepts_nested_attributes_for :images, allow_destroy: true
end
