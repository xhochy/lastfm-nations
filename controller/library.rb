class LastFMNations

  get '/library/list/:name.:format' do
    @name = params['name']
    artists = Scrobbler::Library.new(@name).artists(:all => false)
    @artists = []
    artists.each do |artist|
      country = $resolver.by_scrobbler_tags(artist.top_tags)
      country = "Unknown" if country.nil?
      @artists << [artist.name, artist.playcount, country]
    end
    @title = @name
    
    # Render
    case params[:format]
      when 'xml'
        @content = haml :library_lits_xml
        return haml :default_xml
      when 'xhtml'
        @content = haml :library_list_xhtml
        return haml :default_xhtml
      else
        halt 404
    end
  end

end
