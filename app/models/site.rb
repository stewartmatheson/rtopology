class Site < ActiveRecord::Base
  attr_accessible :description, :site_name, :url, :port
  validates_presence_of :site_name, :url, :port
  has_many :pages
  has_many :audits
  
  def home_page
    Page.find_or_create_by_path("/", :site_id => id)
  end

  def last_audit
    Audit.where(:site_id => id).order("created_at DESC").first
  end

  def as_json options = {}
    { :site_name => site_name, :pages => pages, :audits => audits }
  end
end
