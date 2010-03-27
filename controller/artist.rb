require 'scrobbler'



class ArtistController < Controller

  def classify(name)
    @title = name
    artist = Scrobbler::Artist.new(name)
    countries = Classification::Resolver.by_scrobbler_tags(artist.top_tags)
    text = ""
    countries.each do |name,count| 
      text += "#{name} -> #{count} <br />"
    end
    text += "<br />" * 3 + "<h3>Tags:</h3>"
    artist.top_tags.each do |tag|
      if Classification::Resolver.has_tag?(tag.name)
        text += "<span class=\"recognized-tag\">#{tag.name}(#{tag.count})</span> "
      else
        text += tag.name.downcase + "(#{tag.count}) "
      end
    end
        
    text
  end

end
