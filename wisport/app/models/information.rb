class Information < ActiveRecord::Base
  attr_accessible :description, :images_attributes, :image_ids, :videos_attributes

  belongs_to :exercise
  has_many :images
	has_many :videos
  
  accepts_nested_attributes_for :images, allow_destroy: true
	accepts_nested_attributes_for :videos, allow_destroy: true
end
