require 'bundler/setup'
require 'dotenv'

Dotenv.load
Bundler.require

require_relative 'app'
require_relative 'routes'

# exit unless imagemagick convert is found
App.die('ImageMagick convert not found in path') if `which convert` == ''

# exit uneless unsuported env
App.die('Unsupported RACK_ENV') unless ['production', 'development'].include?(ENV.fetch('RACK_ENV'))
