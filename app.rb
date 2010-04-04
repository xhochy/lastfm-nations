# This file contains your application, it requires dependencies and necessary
# parts of the application.
#
# It will be required from either `config.ru` or `start.rb`

require 'rubygems'
require 'ramaze'

# Include needed gems
require 'scrobbler'
require 'dm-core'

# Include local configuration
require 'local-config'

# Make sure that Ramaze knows where you are
Ramaze.options.roots = [__DIR__]
Ramaze.options.adapter.adapter = :mongrel

require __DIR__('classification/resolver')

# Initialize controllers and models
require __DIR__('model/init')
require __DIR__('controller/init')

DataMapper.auto_migrate!


