class Exercise < ActiveRecord::Base
  
  attr_accessible :name, :title, :type, :information, :visibility, :information_attributes, :owner
  
  has_one :information
	belongs_to :owner, :class_name => "User", :foreign_key => "owner_id"
  has_and_belongs_to_many :trainings_sessions

  validates_presence_of :name
  validates_presence_of :title
  validates_presence_of :type
  validates_presence_of :information
	validates_presence_of :owner

  accepts_nested_attributes_for :information, allow_destroy: true

  def self.visibility_options
    ["All", "Friends", "Private"]
  end
  
  validates_inclusion_of :visibility, :in=>visibility_options, :allow_nil => false

	def self.select_options
		descendants.map{ |c| c.to_s }.sort
	end
def self.inherited(child)
	child.instance_eval do
		def model_name
			Exercise.model_name
		end
	end
	super
end


end

class DistanceExercise < Exercise
	attr_accessible :distance

	validates_presence_of :distance
end
class TimeExercise < Exercise
	attr_accessible :hours, :minutes, :seconds

	validates_presence_of :hours
	validates_presence_of :minutes
	validates_presence_of :seconds
end
class RepsExercise < Exercise
	attr_accessible :reps

	validates_presence_of :reps
end
