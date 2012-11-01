module Rules; end;
module Scrapers; end;

Dir["#{Rails.root}/app/scrapers/*.rb"].each {|file| require file }
Dir["#{Rails.root}/app/rules/*.rb"].each {|file| require file }
