class DoSession < ActiveRecord::Base
	attr_accessible :remarks, :visibility, :user_id, :trainings_session_id, :do_exercises_attributes
	
  belongs_to :user
  belongs_to :trainings_session
	has_many :do_exercises
  
	accepts_nested_attributes_for :do_exercises
end
