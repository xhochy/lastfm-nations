module Helper
  def haml_xml(str)
    @content = haml(str.to_s + "_xml")
    haml :default_xml
  end
end
