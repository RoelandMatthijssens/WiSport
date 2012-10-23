class TrainingsSession < ActiveRecord::Base
  attr_accessible :exercise

  has_and_belongs_to_many :exercises
end
