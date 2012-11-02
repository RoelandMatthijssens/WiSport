class Exercise < ActiveRecord::Base
  attr_accessible :name, :title, :typee, :information, :visibility, :information_attributes
  validates_inclusion_of :visibility, :in=>["all", "friends", "private"], :allow_nil => false
  has_one :information
  has_and_belongs_to_many :trainings_sessions

  validates_presence_of :name
  validates_presence_of :title
  validates_presence_of :typee
  validates_presence_of :information

  accepts_nested_attributes_for :information, allow_destroy: true

  def self.visibility_options
    ["All", "Friends", "Private"]
  end

end
