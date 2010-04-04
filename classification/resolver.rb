module Classification
  module Resolver
    # Internal hasmap to store the tag to country mappings.
    @@tag_map = {}
    
    # Add a tag => country mapping to the list.
    #
    # @param [String] tag The tag mapped to the country (case-insensitive)
    # @param [String] country The country identified be tag (case-sensitive)
    def self.add_mapping(tag, country)
      @@tag_map[tag.downcase] = country
    end
  
    # Classify an artist by its tags on Last.fm.
    #
    # @param [Array<Scrobbler::Tag>] tags The artist's tags from Last.FM
    # @return [Hash<String, Fixnum>] The countries this artist may belong to and
    #                                their score (a higher score => probability
    #                                is higher)
    def self.by_scrobbler_tags(tags)
      countries = {}
      tags.each do |stag|
        # by default we only handle tags case-insensitive
        tag = stag.name.downcase
        if @@tag_map[tag] then
          if countries[@@tag_map[tag]] == nil
            countries[@@tag_map[tag]] = [stag.count, 1].max
          else
            countries[@@tag_map[tag]] += [stag.count, 1].max
          end
        end
      end
      
      countries
    end
    
    # Do we already know about a tag?
    #
    # @param [String] tag The tag that should be checked if we already have a
    #                     mapping including it.
    # @return [Boolean] True, if there is a mapping including this tag.
    def self.has_tag?(tag)
      @@tag_map.has_key?(tag.downcase)
    end
    
  end
end

[
  'albania', 'algeria', 'argentina', 'australia', 'austria',
  'belarus', 'belgium', 'bosnia', 'brazil', 'bulgaria', 'benin', 'bolivia',
  'bahamas',
  'cameroon', 'canada', 'china', 'chile', 'colombia', 'cape-verde', 'cuba',
  'cyprus', 'czech-republic', 'croatia',
  'democratic-republic-of-the-congo', 'denmark',
  'estonia',
  'france', 'faroe-islands', 'finland',
  'germany', 'greece',
  'ireland', 'island-of-dominica', 'ivory-coast', 'italy', 'iceland',
  'japan',
  'lebanon', 'luxembourg',
  'macedonia',
  'norway',
  'philippines', 'puerto-rico',
  'russia',
  'spain', 'sweden', 'south-africa',
  'uk', 'usa'
].each do |country|
  load File.join(File.dirname(__FILE__), 'countries', country + '.rb');
end

=begin
    'hungarian' => 'Hungary',
    'hungary' => 'Hungary',
    'iran' => 'Iran',
    'iranian' => 'Iran',
    'israel' => 'Israel',
    'israeli' => 'Israel',
    'israelian' => 'Israel',
    'indian' => 'India',
    'india' => 'India',
    'indian classical' => 'India',
    'indian music' => 'India',
    'indian rock' => 'India',
    'south indian music' => 'India',
    'jamaica' => 'Jamaica',
    'jamaican' => 'Jamaica',
    'korea' => 'Korea',
    'korean' => 'Korea',
    'korean pop' => 'Korea',
    'kyrgyzstan' => 'Kyrgystan',
    'kazakhstan' => 'Kazakhstan',
    'kazakh' => 'Kazakhstan',
    'kazakh rock' => 'Kazakhstan',
    'kazakhstani' => 'Kazakhstan',
    'khazakhstanian folk rock' => 'Kazakhstan',
    'latvia' => 'Latvia',
    'latvian' => 'Latvia',
    'lithuania' => 'Lithuania',
    'lithuanian' => 'Lithuania',
    'lithuanian metal' => 'Lithuania',
    'malaysia' => 'Malaysia', 
    'mali' => 'Mali',
    'mexico' => 'Mexico',
    'mexican' => 'Mexico',
    'mexico city' => 'Mexico',
    'mexican electronic music' => 'Mexico',
    'mexican rock' => 'Mexico',
    'moldavia' => 'Moldavia',
    'moldova' => 'Moldavia',
    'mongolia' => 'Mongolia',
    'maroc' => 'Morocco',  
    'marocain' => 'Morocco',  
    'marocaine' => 'Morocco',  
    'marokko' => 'Morocco',  
    'marroccan' => 'Morocco',
    'marruecos' => 'Morocco',
    'moroccan' => 'Morocco',
    'moroccan pop' => 'Morocco',
    'morocco' => 'Morocco',
    'dutch' => 'Netherlands',
    'nederlands' => 'Netherlands',
    'netherlands' => 'Netherlands',
    'rotterdam' => 'Netherlands',
    'rotterdam techno' => 'Netherlands',
    'holland' => 'Netherlands',
    'new zealand' => 'New Zealand',
    'kiwi' => 'New Zealand',
    'new zealand music' => 'New Zealand',
    'peru' => 'Peru',
    'peruian' => 'Peru',
    'peruvian' => 'Peru',
    'peruvian rock' => 'Peru',
    'polish' => 'Poland',
    'polish music' => 'Poland',
    'polish punk' => 'Poland',
    'poland' => 'Poland',
    'polisz' => 'Poland',
    'polska' => 'Poland',
    'portugal' => 'Portugal',
    'portuguesa' => 'Portugal',
    'portuguese' => 'Portugal',
    'portuguese folk' => 'Portugal',
    'portuguese music' => 'Portugal',
    'portuguese guitar' => 'Portugal',
    'romanesc' => 'Romania',
    'romania' => 'Romania',
    'romanian' => 'Romania',
    'senegal' => 'Senegal',
    'senegalese' => 'Senegal',
    'serbia' => 'Serbia',
    'serbian' => 'Serbia',
    'slovenia' => 'Slovenia',
    'slovenian' => 'Slovenia',
    'slovak' => 'Slovakia',
    'slovak pop' => 'Slovakia',
    'slovak stream' => 'Slovakia',
    'swiss' => 'Switzerland',
    'switzerland' => 'Switzerland',
    'taiwan' => 'Taiwan',
    'taiwanese' => 'Taiwan',
    'tanzania' => 'Tanzania',
    'tanzanian' => 'Tanzania',
    'thai' => 'Thailand',
    'thai pop' => 'Thailand',
    'thai artist' => 'Thailand',
    'thai artists' => 'Thailand',
    'thailand' => 'Thailand',
    'trinidad' => 'Trinidad & Tobago',
    'tobago' => 'Trinidad & Tobago',
    'turkish' => 'Turkey',
    'turkey' => 'Turkey',
    'tunisia' => 'Tunisia',
    'tunisian' => 'Tunisia',
    'ukraine' => 'Ukraine',
    'ukrainian' => 'Ukraine',
    'ukrainian alternative' => 'Ukraine',
    'uruguay' => 'Uruguay',
    'uruguayan' => 'Uruguay',
    'uruguayan pop' => 'Uruguay',
    'zambia' => 'Zambia'
=end
