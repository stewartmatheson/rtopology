module Scrapers
  class SiteScraper
    def initialize site
      @site = site
    end

    def run
      puts "[INFO] Scraping Site #{@site.url}"
      audit = Audit.create(:site_id => @site.id)

      #Look up and respect robots.txt
      connection = Faraday.new(@site.url) do |faraday|
        faraday.adapter Faraday.default_adapter 
      end
      connection.headers[:user_agent] = "RTopology Spider v.(Alpha) https://github.com/stewartmatheson/rtopology"
      response = connection.get('/robots.txt')
      

      Scrapers::PageScraper.new(@site.home_page).run
      @site.pages.each { |page| Scrapers::PageScraper.new(page).run }
      #make sure that every page is scraped
      while !audit.complete?
        pages_to_scrape = @site.pages.all - audit.pages.all
        pages_to_scrape.each { |page| Scrapers::PageScraper.new(page).run }
      end
    end
  end
end
