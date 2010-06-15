# This file contains your application, it requires dependencies and necessary
# parts of the application.
#
# It will be required from `config.ru`

# Include needed gems
require 'rubygems'
require 'bundler'
Bundler.setup 

require 'dm-core'
require 'haml'
require 'scrobbler'
require 'sinatra/base'

# Include local configuration
require 'local-config'

# Load the Classification backend
require 'lib/classification/resolver'
$resolver = Classification::Resolver.new(:source => :files, :files => 
  File.join(File.dirname(__FILE__), 'lib', 'classification', 'countries', 
    '*.yml'))

# Load the database models
require 'model/artist'
require 'model/playcount'
require 'model/library'
DataMapper.auto_upgrade!

# Load the Controllers
class LastFMNations < Sinatra::Base

  set :public, File.dirname(__FILE__) + '/public'

  get '/' do
    'This is the Nationality Statistics Server.'
  end

end

require 'controller/library'
require 'controller/artist'
