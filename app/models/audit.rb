class Audit < ActiveRecord::Base
  attr_accessible :site_id
  belongs_to :site
  has_many :reports
end
