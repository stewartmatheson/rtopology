class Site < ActiveRecord::Base
  attr_accessible :description, :site_name, :url, :port
  validates_presence_of :site_name, :url, :port
  has_many :pages, :dependent => :delete_all
  has_many :audits, :dependent => :delete_all
  
  def home_page
    Page.find_or_create_by_path("/", :site_id => id)
  end

  def last_audit
    Audit.where(:site_id => id).order("created_at DESC").first
  end

  def uri
    return "#{url}:#{port.to_s}" unless port == 80 
    url 
  end 
end
