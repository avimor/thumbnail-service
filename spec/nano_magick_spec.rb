ENV['RACK_ENV'] = 'test'
require 'dotenv'
Dotenv.load
require './app/app'
require './app/lib/image'

describe 'nano magick' do

  let(:params) {
    {
      url: 'http://googlechrome.github.io/samples/picture-element/images/butterfly.jpg',
      width: '160',
      height: '120'
    }
  }

  [:curl, :convert, :identify].each do |cmd|
    it 'should find %s in path' % cmd do
      expect(`which #{cmd}`.length > 1).to eq(true)
    end
  end

  it 'should resize image' do
    img = NanoMagick::Image.new(params[:url])
    resized = img.resize(params[:width], params[:height], true)
    expect(File.exist?(resized)).to eq(true)
    info = `identify #{resized}`.split(' ')
    expect(info[3]).to eq('160x120+0+0')
    File.unlink(resized) if File.exist?(resized)
  end
end
