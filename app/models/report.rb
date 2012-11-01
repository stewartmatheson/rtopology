class Report < ActiveRecord::Base
  attr_accessible :message, :score
  belongs_to :audit, :dependent => :destroy
  belongs_to :page, :dependent => :destroy
  validates :message, :presence => true, :uniqueness => {:scope => :page_id}
end
