class ArtistController < Controller
  engine :Haml
  layout :default
  provide :xml, :engine => :Haml
  
  COUNTRY_FILES = File.join(File.dirname(__FILE__), '..', 'classification',
    'countries', '*.yml')

  def self.init_resolver
    Classification::Resolver.new(:source => :files, :files => COUNTRY_FILES)
  end

  def classify(name)
    @resolver = ArtistController::init_resolver if @resolver.nil?
    @title = name
    artist = Scrobbler::Artist.new(name)
    top_tags = artist.top_tags
    @countries = @resolver.by_scrobbler_tags_ex(top_tags)
    @recognized_tags = {}
    @unrecognized_tags = {}
    top_tags.each do |tag|
      if @resolver.has_tag?(tag.name)
        @recognized_tags[tag.name] = tag.count  
      else
        @unrecognized_tags[tag.name] = tag.count
      end
    end
  end

end
