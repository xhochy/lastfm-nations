# This file contains your application, it requires dependencies and necessary
# parts of the application.
#
# It will be required from `config.ru`

# Include needed gems
require 'rubygems'
require 'dm-core'
require 'haml'
require 'scrobbler'
require 'sinatra/base'

# Include local configuration
require 'local-config'

# Load the Classification backend
require File.join(File.dirname(__FILE__), 'lib', 'classification', 'resolver')
$resolver = Classification::Resolver.new(:source => :files, :files => 
  File.join(File.dirname(__FILE__), 'classification', 'countries', 
    '*.yml'))

DataMapper.auto_migrate!

# Load the Controllers
class LastFMNations < Sinatra::Base
  get '/' do
    'This is the Nationality Statistics Server.'
  end
  
  get '/artist/classify/:name.:format' do
    @name = params[:name]
    @title = @name 
    @country = $resolver.by_scrobbler_tags(Scrobbler::Artist.new(:name => @name).top_tags)
    case params[:format]
      when 'xml'
        return haml :artist_classify_xml
      when 'xhtml'
        return haml :artist_classify_xhtml
      else
        halt 404
    end
  end

end

