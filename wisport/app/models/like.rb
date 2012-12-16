class Like < ActiveRecord::Base
	attr_accessible :likable_id, :likable_type, :user_id
	
  belongs_to :user
	belongs_to :likable, :polymorphic => true
  
	scope :exercises, where("likable_type = 'Exercise'")
	scope :sessions, where("likable_type = 'TrainingsSession'")
	scope :for_user, lambda { |id| where("user_id = ?", id) }
	scope :by_exercise, lambda { |id| exercises.where("likable_id = ?", id) }
	scope :by_sessions, lambda { |id| where("likable_id = ?", id) }
	
end
