require 'logger'

module App
  extend self
  attr_reader :root, :version

  @root = File.expand_path('..', File.dirname(__FILE__))
  for dir in ['log', 'cache', 'cache/originals', 'cache/resized']
    dir = "#{@root}/#{dir}"
    Dir.mkdir(dir) unless Dir.exist?(dir)
  end
  @version = File.read('.version')
  ICON = File.read('./public/favicon.ico')
  LOG_FILE = './log/%s.log' % ENV['RACK_ENV']
  LOGGER = Logger.new(LOG_FILE, 'weekly')
  LOGGER.datetime_format = '%F %R'

  def call(env)
    app = new env
    app.router
    app.deliver
  end

  def log(text)
    LOGGER.info  text
  end

  def die(text)
    puts text.red
    exit
  end
end
