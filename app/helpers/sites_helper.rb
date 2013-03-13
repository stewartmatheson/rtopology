module SitesHelper
  def page_status_class page
    return "red" if (500..599).include?(page.response_code)
    "green"
  end
end
