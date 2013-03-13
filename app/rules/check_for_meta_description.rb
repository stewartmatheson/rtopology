module Rules::CheckForDescription
  def self.execute document 
    results = []
    if(document.css('meta[name=description]').count == 0)
      results << {  :score => 5, 
                    :message => "You have no meta description in the head tag of this page" }
    end
    results
  end
end
