module Scrapers
  class SiteScraper
    def initialize site
      @site = site
    end

    def run
      puts "[INFO] Scraping Site #{@site.url}"
      audit = Audit.create(:site_id => @site.id)
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
