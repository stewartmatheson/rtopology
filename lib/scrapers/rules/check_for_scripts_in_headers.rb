module Scrapers::Rules::CheckForScriptsInHeaders
  def self.execute document 
    results = []
    if(document.css('head script').count > 1)
      results << { :score => 5, :message => "You have scripts in the head part of the doucment" }
    end 
    results
  end
end
