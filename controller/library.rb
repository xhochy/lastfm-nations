class LibraryController < Controller
  engine :Haml
  layout :default
  provide :xml, :engine => :Haml
  
  def list(name)
    artists = Scrobbler::Library.new(name).artists(:all => false)
    @artists = []
    artists.each do |artist|
      country = $resolver.by_scrobbler_tags(artist.top_tags)
      country = "Unknown" if country.nil?
      @artists << [artist.name, artist.playcount, country]
    end
    @title = name
  end
end
