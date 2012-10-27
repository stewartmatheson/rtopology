module Scrapers::Rules::CheckForTitle
  def self.execute document 
    results = []
    if(document.css('title').count == 0)
      results << { :score => 8, :message => "There is no title set" }
    end 
    results
  end
end
