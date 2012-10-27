module Scrapers
  class PageScraper
    def initialize page
     @page = page
    end
    
    def run
      puts "[INFO] Scraping Page #{@page.site.url}#{@page.path}"
      connection = Faraday.new(@page.site.url) do |faraday|
        faraday.adapter Faraday.default_adapter 
      end
      @response = connection.get(@page.path)

      document = Nokogiri::HTML(@response.body)
      document.css('a').each do |link|
        p = Page.new(:path => link["href"], :site_id => @page.site.id, :discovered_id => @page.id)
        p.save
      end
      
      execute_rules(document)
    end

    private

    def execute_rules document
      results = []
      %W(CheckForTitle CheckForCanonicalLink).each do |scraper_rule|
        results << Scrapers::Rules.const_get(scraper_rule).execute(document)
      end
      
      results.flatten!.each do |result|
        r = Report.new(result)        
        r.page = @page
        r.audit = @page.site.last_audit 
        r.save
      end

      @page.save
    end

  end
end
