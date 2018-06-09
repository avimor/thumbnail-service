require 'bundler/setup'
require 'dotenv'

Dotenv.load
Bundler.require

require_relative 'app'
require_relative 'routes'

# exit unless imagemagic convert is found
App.die('ImageMagic convert not found in path') if `which convert` == ''

# exit uneless unsuported env
App.die('Unsupported RACK_ENV') unless ['production', 'development'].include?(ENV.fetch('RACK_ENV'))

# create needed folers
for dir in ['log', 'cache', 'cache/originals', 'cache/resized']
  dir = "#{App.root}/#{dir}"
  Dir.mkdir(dir) unless Dir.exists?(dir)
end
