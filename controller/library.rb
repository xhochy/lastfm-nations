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
    
    countries = {}
    @artists.each do |artist|
      country = artist.at(2)
      if countries[country].nil?
        countries[country] = artist.at(1)
      else 
        countries[country] += artist.at(1)
      end
    end
    countries = countries.to_a
    countries.sort_by{|i| -i[1]}
    
    playcounts = []
    country_strings = []
    others = 0
    countries.each do |country|
      # Do not list countries with nearly no scrobbles
      if not country[1] < (0.025 * countries[0][1]) then
        country[0] = "UK" if country[0] == "United Kingdom"
        playcounts << (country[1]*100)/countries[0][1]
        if country[0] == "United Kingdom" then
          country_strings << "UK"
        elsif country[0] == "United States" then
          country_strings << "USA"
        else  
          country_strings << country[0]
        end
      else
        others += country[1]
      end
    end
    if others > 0 then
      playcounts << others
      country_strings << "Others"
    end
    
    @pie_chart_url = "http://chart.apis.google.com/chart?cht=p&chf=bg,s," + 
      "e3e3e300&chs=350x150&chd=t:" + playcounts.join(",") + "&chl=" + 
      country_strings.join("|")
    
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
