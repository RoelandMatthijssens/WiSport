class DoSession < ActiveRecord::Base
	attr_accessible :remarks, :visibility, :user_id, :trainings_session_id, :do_exercises_attributes, :done_at
	
  belongs_to :user
  belongs_to :trainings_session
	has_many :do_exercises
  
	accepts_nested_attributes_for :do_exercises
	validates_presence_of :user, :trainings_session, :visibility
end
