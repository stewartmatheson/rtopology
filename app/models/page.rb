class Page < ActiveRecord::Base
  attr_accessible :path, :site_id, :results, :discovered_id, :response_code, :response_time, :last_audited_at, :last_error, :last_error_at, :digest

  belongs_to :site, :dependent => :destroy
  belongs_to :discovered, :class_name => "Page", :foreign_key => "discovered_id"
  has_many :reports

  validates_presence_of :path
  validates :path, :uniqueness => { :scope => :site_id, :message => "already scraped" }
  validate :check_for_correct_host, :check_for_slash, :check_not_mailto
  after_validation :format_path

  def check_for_correct_host
    if(URI(path).host != URI(site.url).host && URI(path).host != nil)
      errors.add(:path, "is offsite") 
    end
  rescue 
    errors.add(:path, "can not be processed") 
  end
  
  def check_for_slash 
    if !(URI(path).path.match(/^\//))
      errors.add(:path, "does not start with a slash") 
    end
  rescue
    false
  end

  def check_not_mailto
    if path.match /^mailto:/
      errors.add(:path, "should not be a mailto link") 
    end
  rescue
    false
  end

  def format_path
    path = URI(path.to_s).path
  end

  def as_json options = {}
    { :path => path }
  end

  def page_reports
    audits = []
    audits << OpenStruct.new({ :message => "This page's url is #{path.length} chars. This is a little long." }) unless path.length < 115
    audits
  end
end
