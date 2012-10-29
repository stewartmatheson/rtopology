module Scrapers::Rules::CheckForDescription
  def self.execute document 
    results = []
    if(document.css('meta[name=keywords]').count == 0)
      results << {  :score => 5, 
                    :message => "You have no meta description set on this page" }
    end 
    results
  end
end
