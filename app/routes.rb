require 'sinatra'

require_relative 'lib/image'

def resize_image
  url = @params[:url]
  return "[url] not specified" unless url.to_s.length > 1
  width, height = @params[:size].to_s.split('x')
  width ||= @params[:width]
  height ||= @params[:height]
  return "[size] not specified" unless width || height
  img = NanoMagick::Image.new(url)
  reload = @params[:reload] ? true : false
#  reload = true if request.env['HTTP_CACHE_CONTROL'] == 'no-cache'
  file = img.resize(width, height, reload, @params)
  response.headers['accept-ranges'] = 'bytes'
  response.headers['cache-control'] = 'public, max-age=10000000, no-transform'
#  response.headers['etag'] = Digest::MD5.hexdigest(data)
  send_file file
end

get '/thumbnail' do
  resize_image
end

get '/' do
  erb 'Thumnail service is up'
end

get '/env' do
  raise '%s environment detalis:' % ENV['RACK_ENV']
end

get '/log' do
  lines = `tail -n 500 #{App::LOG_FILE}`.split($/).reverse.join($/)
  content_type :text
  lines
end
