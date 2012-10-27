namespace :scraper do
  desc "Run the scraper on all pages"
  task :run => :environment do
    Site.all.each do |site|
      Scrapers::SiteScraper.new(site).run 
    end
  end
end
