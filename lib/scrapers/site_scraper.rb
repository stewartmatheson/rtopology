module Scrapers
  class SiteScraper
    def initialize site
      @site = site
    end

    def run
      puts "[INFO] Scraping Site #{@site.url}"
      Audit.create(:site_id => @site.id)
      Scrapers::PageScraper.new(@site.home_page).run
      @site.pages.each { |page| Scrapers::PageScraper.new(page).run }
    end
  end
end
