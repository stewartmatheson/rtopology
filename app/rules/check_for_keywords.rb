module Rules::CheckForKeywords
  def self.execute document 
    results = []
    if(document.css('meta[name=keywords]').count == 0)
      results << {  :score => 5, 
                    :message => "You have no meta keywords in the head tag of this page" }
    end 
    results
  end
end
