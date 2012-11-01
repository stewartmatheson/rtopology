module Rules::CheckForScriptsInHeaders
  def self.execute document 
    results = []
    if(document.css('head script').count > 1)
      results << {  :score => 5, 
                    :message => "You have scripts in the head part of the doucment. To speed up pages place script tags just before the close of the body tag" }
    end 
    results
  end
end
