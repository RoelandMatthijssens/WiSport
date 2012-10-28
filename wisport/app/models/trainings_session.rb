class TrainingsSession < ActiveRecord::Base
  attr_accessible :exercises
  
  has_and_belongs_to_many :exercises
end
