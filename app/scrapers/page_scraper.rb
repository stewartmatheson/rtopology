require 'digest/md5'

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


        # find all scripts that are part of this page
        document.css('script').each do |script_tag|
          # skip this if the script does not have a source
          next unless script_tag.attribute('src')
          # We don't want to know about anything else but javascript
          next unless script_tag.attribute('type').value == 'text/javascript';

          # after checks log the asset in the db
          a = Asset.create(
            :page_id => @page.id, 
            :asset_type => 'javascript', 
            :path => script_tag.attribute('src').value
          )
          puts "    Discoverd Javascript #{a.path}" if a.errors.empty?
        end

        #next lets remember all the style sheets
        document.css('link').each do |link_tag|
          # skip this if the script does not have a source
          next unless link_tag.attribute('type')
          next unless link_tag.attribute('type').value == 'text/css'
          a = Asset.create(
            :page_id => @page.id, 
            :asset_type => 'stylesheet', 
            :path => link_tag.attribute('href').value
          )
          puts "    Discoverd Stylesheet #{a.path}" if a.errors.empty?
        end

        execute_rules(document)
      rescue => e
        puts "[ERROR] #{e}"
        @page.last_error = e
        @page.last_error_at = Time.now
      end
    end

    private

    def execute_rules document
      results = []
      %W( CheckForTitle
          CheckForCanonicalLink
          CheckForDescription
          CheckForKeywords
          CheckForScriptsInHeaders
          CheckForMultiScripts).each do |scraper_rule|
        results << Rules.const_get(scraper_rule).execute(document)
      end
      
      @page.reports.delete_all     
 
      results.flatten!.each do |result|
        r = Report.new(result)        
        r.page = @page
        r.audit = @page.site.last_audit 
        r.save
      end
      
      @page.digest = Digest::MD5.hexdigest(@response.body)
      @page.last_audited_at = Time.now
      @page.save
    end

  end
end
