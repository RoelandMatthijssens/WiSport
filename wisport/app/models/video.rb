class Video < ActiveRecord::Base
  belongs_to :information
  attr_accessible :link, :information_id
end
