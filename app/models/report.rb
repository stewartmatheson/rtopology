class Report < ActiveRecord::Base
  attr_accessible :message, :score
  belongs_to :audit 
  belongs_to :page
end
