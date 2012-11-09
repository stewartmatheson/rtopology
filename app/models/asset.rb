class Asset < ActiveRecord::Base
  attr_accessible :asset_type, :md5, :page_id, :path, :size
  belongs_to :page, :dependent => :destroy
end
