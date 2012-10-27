module Scrapers::Rules::CheckForCanonicalLink
  def self.execute document 
    results = []
    if(document.css('link[rel=canonical]').count == 0)
      results << { :score => 5, :message => "There is no canonical link set" }
    end 
    results
  end
end
