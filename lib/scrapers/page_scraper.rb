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
      connection.headers[:user_agent] = "RTopology Spider v.(Alpha) https://github.com/stewartmatheson/rtopology"

      begin
        start_time = Time.now
        @response = connection.get(@page.path)
        end_time = Time.now

        #follow redirects
        while @response.status == 301 || @response.status == 307
          start_time = Time.now
          @response = connection.get(@response.env[:response_headers]["location"])
          end_time = Time.now
        end

        # update page
        @page.response_time = ((end_time - start_time) * 1000).to_i
        @page.response_code = @response.status

        document = Nokogiri::HTML(@response.body)
        document.css('a').each do |link|
          p = Page.new( :path => link["href"], 
                        :site_id => @page.site.id, 
                        :discovered_id => @page.id)
          p.save
        end
      
        execute_rules(document)
      rescue => e
        "[ERROR] #{e}"
        @page.last_error = e
        @page.last_error_at = Time.now
      end
    end

    private

    def execute_rules document
      results = []
      %W(CheckForTitle CheckForCanonicalLink).each do |scraper_rule|
        results << Scrapers::Rules.const_get(scraper_rule).execute(document)
      end
      
      @page.reports.delete_all     
 
      results.flatten!.each do |result|
        r = Report.new(result)        
        r.page = @page
        r.audit = @page.site.last_audit 
        r.save
      end
      
      @page.last_audited_at = Time.now
      @page.save
    end

  end
end
