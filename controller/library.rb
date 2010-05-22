class LastFMNations

  get '/library/list/:name.:format' do
    @name = params['name']
    # Check if we already have a record for this name
    library = Library.first(:username => @name)
    @artists = []
    if library.nil?
      # Fill/Renew that cache
      library = Library.new
      library.username = @name
      puts library.playcounts.class
      artists = Scrobbler::Library.new(@name).artists(:all => false)
      artists.each do |artist|
        db_artist = Artist.first(:name => artist.name)
        if db_artist.nil?
          country = $resolver.by_scrobbler_tags(artist.top_tags)
          country = "Unknown" if country.nil?
          db_artist = Artist.new
          db_artist.name = artist.name
          db_artist.country = country
          db_artist.save
        else
          country = db_artist.country
        end
        @artists << [artist.name, artist.playcount, country]
        playcount = library.playcounts.new(:count => artist.playcount, :artist => db_artist)
        library.playcounts << playcount
      end
      library.save
    else
      library.playcounts.each do |playcount|
        @artists << [playcount.artist.name, playcount.count, playcount.artist.country]
      end
    end
    @title = @name
    
    # Render
    case params[:format]
      when 'xml'
        @content = haml :library_list_xml
        return haml :default_xml
      when 'xhtml'
        @content = haml :library_list_xhtml
        return haml :default_xhtml
      else
        halt 404
    end
  end

end
