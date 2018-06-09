require 'open-uri'

module NanoMagick

  class Image
    attr_reader :src, :ext, :cache

    def initialize(src)
      @src = src
      @ext = File.extname(@src).strip.downcase
      @ext ||= '.jpg'
      @cache = "#{App.root}/cache/originals/#{md5(@src)}#{@ext}"
    end

    def md5 data
      ret = Digest::MD5.hexdigest data
      ret[2,0] = ''
      ret
    end

    def log text
      App.log text
    end

    def download(reload = false)
      File.unlink(@cache) if reload && File.exist?(@cache)
      return @cache if File.exist?(@cache)
      open(@src) do |uri|
        File.binwrite(@cache, uri.read)
        log 'Downloaded %s to %s (%d kb)' % [@src, @cache, uri.size/1024]
      end
      @cache
    end

    def resize(width, height, reload = false, options = {})
      size = "#{width}x#{height}"
      resized = "#{App.root}/cache/resized/#{size}-#{md5(@src)}#{@ext}"
      File.unlink(resized) if reload && File.exist?(resized)
      return resized if File.exist?(resized)
      download(reload)
      gv = options[:gravity] ? options[:gravity] : 'center'
      bg = options[:background] ? options[:background] : 'black'
      cmd = "convert '#{@cache}' -resize \"#{size}>\" -background #{bg} -gravity #{gv} -extent #{size} '#{resized}' 2>&1"
      log 'Executing command %s' % cmd
      out = `#{cmd}`
      unless $?.exitstatus == 0
        File.unlink(resized) if File.exist?(resized)
        raise 'Resize error: %s' % out
      end
      log 'Resized %s to %s (%s)' % [@src, resized, size]
      resized
    end

  end
end
