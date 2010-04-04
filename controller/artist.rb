require 'scrobbler'

require File.join(File.dirname(__FILE__), '..', 'api-key')

class ArtistController < Controller

  COUNTRY_FILES = File.join(File.dirname(__FILE__), '..', 'classification',
    'countries', '*.yml')

  def self.init_resolver
    Classification::Resolver.new(:source => :files, :files => COUNTRY_FILES)
  end

  def classify(name)
    @resolver = ArtistController::init_resolver if @resolver.nil?
    @title = name
    artist = Scrobbler::Artist.new(name)
    countries = @resolver.by_scrobbler_tags(artist.top_tags)
    text = ""
    countries.each do |name,count| 
      text += "#{name} -> #{count} <br />"
    end
    text += "<br />" * 3 + "<h3>Tags:</h3>"
    artist.top_tags.each do |tag|
      if @resolver.has_tag?(tag.name)
        text += "<span class=\"recognized-tag\">#{tag.name}(#{tag.count})</span> "
      else
        text += tag.name.downcase + "(#{tag.count}) "
      end
    end
        
    text
  end

end
