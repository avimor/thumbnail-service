require 'logger'

module App
  extend self

  ROOT = File.expand_path('..', File.dirname(__FILE__))
  ICON = File.read('./public/favicon.ico')
  LOG_FILE = './log/%s.log' % ENV['RACK_ENV']
  LOGGER = Logger.new(LOG_FILE, 'weekly')
  LOGGER.datetime_format = '%F %R'

  def call env
    app = new env
    app.router
    app.deliver
  end

  def log text
    LOGGER.info text
  end

  def root
    ROOT
  end

  def die text
    puts text.red
    exit
  end
end
