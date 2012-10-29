class Exercise < ActiveRecord::Base
  attr_accessible :name, :title, :typee, :information, :information_attributes

  has_one :information
  has_and_belongs_to_many :trainings_sessions

	validates_presence_of :name
	validates_presence_of :title
	validates_presence_of :typee
	validates_presence_of :information
	
	accepts_nested_attributes_for :information, allow_destroy: true
end
