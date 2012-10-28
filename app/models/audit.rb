class Audit < ActiveRecord::Base
  attr_accessible :site_id
  belongs_to :site
  has_many :reports
  has_many :pages, :through => :reports

  def complete?
    site.pages.count <= pages.count
  end
end
