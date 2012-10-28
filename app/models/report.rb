class Report < ActiveRecord::Base
  attr_accessible :message, :score
  belongs_to :audit 
  belongs_to :page
  validates :message, :presence => true, :uniqueness => {:scope => :page_id}
end
