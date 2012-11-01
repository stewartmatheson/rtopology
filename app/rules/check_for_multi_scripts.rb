module Rules::CheckForMultiScripts
  def self.execute document 
    results = []
    if(document.css('script').count > 5)
      results << { :score => 5, :message => "You have #{document.css('script').count} scripts included on this page. Try and compile them in to one script" }
    end 
    results
  end
end
