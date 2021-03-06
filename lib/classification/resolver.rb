module Classification
  # Class which resolves an artist to its nationality
  class Resolver    
    # Create a new resolver instance
    #
    # Files must be in YAML format and containg a Hash of the structure
    # { :country => String, :tags => [String, ..] }
    #
    # @param [Hash] opts The options to create a new instance with.
    # @option opts [Symbol] :source The source to load the initial mappings
    #                               (:files, :file)
    # @option opts [Array<String>] :files A list of file names (could be regular
    #                                     expressions, e.g. 'lib/**/*.yml')
    # @option opts [String] :file A specific file (no regular expression)
    def initialize(opts = {})
      @tag_map = {}
      
      case opts[:source]
        when :file
          load_file(opts[:file])
        when :files
          load_files(opts[:files])
        else
          raise ArgumentError 'Given source type is not supported.'
      end
    end
    
    # Loads the specified Files 
    #
    # @param [Array<String>] files A list of file names (could be regular
    #                              expressions, e.g. 'lib/**/*.yml')
    def load_files(files)
      Dir.glob(files).each do |file|
        load_file(file)
      end
    end
    
    # Load a given file
    #
    # @param [String] file A file name where to load mappings from.
    def load_file(file)
      file_data = YAML.load(File.read(file))
      country = file_data[:country]
      file_data[:tags].each do |tag|
        @tag_map[tag.downcase] = country
      end
    end
    
    # Add a tag => country mapping to the list.
    #
    # @param [String] tag The tag mapped to the country (case-insensitive)
    # @param [String] country The country identified be tag (case-sensitive)
    def add_mapping(tag, country)
      @tag_map[tag.downcase] = country
    end
  
    # Classify an artist by its tags on Last.fm.
    #
    # Extended version: Returns all possible countries.
    #
    # @param [Array<Scrobbler::Tag>] tags The artist's tags from Last.FM
    # @return [Hash<String, Fixnum>] The countries this artist may belong to and
    #   their score (a higher score => probability is higher)
    def by_scrobbler_tags_ex(tags)
      countries = {}
      tags.each do |tag|
        # by default we only handle tags case-insensitive
        country = @tag_map[tag.name.downcase]
        if !country.nil? then
          countries[country] = Resolver::__count_tag(tag, countries[country])
        end
      end
      
      countries
    end
    
    
    # Classify an artist by its tags on Last.fm.
    #
    # @param [Array<Scrobbler::Tag>] tags The artist's tags from Last.FM
    # @return [Hash<String, Fixnum>] The country this artist may belong to
    def by_scrobbler_tags(tags)
      result = by_scrobbler_tags_ex(tags).to_a.each { |s| s.reverse! }.max
      result[1] unless result.nil?
    end
    
   
    # Do we already know about a tag?
    #
    # @param [String] tag The tag that should be checked if we already have a
    #                     mapping including it.
    # @return [Boolean] True, if there is a mapping including this tag.
    def has_tag?(tag)
      @tag_map.has_key?(tag.downcase)
    end

    # Helper function to compute tag count and an maybe-nil entry
    #
    # @private
    # @param tag [Scrobbler::Tag]
    # @param entry [Fixnum, Nil]
    def self.__count_tag(tag, entry)
      count = (entry.nil? ? 0 : entry)
      count += [tag.count, 1].max
    end    

  end
end

=begin
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
