namespace :scraper do
  desc "Run the scraper on all pages"
  task :run => :environment do
    Site.all.each do |site|
      begin
        Scrapers::SiteScraper.new(site).run 
      rescue Faraday::Error::ConnectionFailed => e
        puts "[ERROR] #{e}"
      end
    end
  end
end
