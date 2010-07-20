# Main class for all Requests
class LastFMNations
  
  get '/artist/classify/:name.:format' do
    @name = params[:name]
    @title = @name 
    @country = $resolver.by_scrobbler_tags(Scrobbler::Artist.new(:name => @name).top_tags)
    
    # Render
    case params[:format]
      when 'xml'
        @content = haml :artist_classify_xml
        return haml :default_xml
      when 'xhtml'
        @content = haml :artist_classify_xhtml
        return haml :default_xhtml
      else
        halt 404
    end
  end
  
  get '/artist/info/:name.:format' do
    @name = params[:name]
   artist = Scrobbler::Artist.new(:name => @name)
    @title = @name 
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

    # Render
    case params[:format]
      when 'xml'
        @content = haml :artist_info_xml
        return haml :default_xml
      when 'xhtml'
        @content = haml :artist_info_xhtml
        return haml :default_xhtml
      else
        halt 404
    end
  end

end

