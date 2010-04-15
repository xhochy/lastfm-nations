# This file contains your application, it requires dependencies and necessary
# parts of the application.
#
# It will be required from `config.ru`

# Include needed gems
require 'rubygems'
require 'sinatra/base'
require 'scrobbler'
require 'dm-core'

# Include local configuration
require 'local-config'

# Load the Classification backend
require File.join(File.dirname(__FILE__), 'lib', 'classification', 'resolver')
$resolver = Classification::Resolver.new(:source => :files, :files => 
  File.join(File.dirname(__FILE__), 'classification', 'countries', 
    '*.yml'))

DataMapper.auto_migrate!


class LastFMNations < Sinatra::Base
  get '/' do
    'Hello World!'
  end
end

