class ArtistController < Controller
  engine :Haml
  layout :default
  provide :xml, :engine => :Haml
  
  def classify(name)
    @title = name
    @country = $resolver.by_scrobbler_tags(Scrobbler::Artist.new(:name => name).top_tags)
  end

  def info(name)
    @title = name
    artist = Scrobbler::Artist.new(:name => name)
    top_tags = artist.top_tags
    @countries = $resolver.by_scrobbler_tags_ex(top_tags)
    @recognized_tags = {}
    @unrecognized_tags = {}
    top_tags.each do |tag|
      if $resolver.has_tag?(tag.name)
        @recognized_tags[tag.name] = tag.count  
      else
        @unrecognized_tags[tag.name] = tag.count
      end
    end
  end

end
