Rack thumbnail service
=====================

Small, simple and fast thumbnail service, written in Ruby using ImageMagick, Sinatra & Rack/Puma

### Installation

Install Ruby

http://www.ruby-lang.org/en/documentation/installation

Install bundler

`gem install bundler`

Clone the app

`git clone https://github.com/avimor/thumbnail-service.git`

chdir an bundle

`cd thumbnail-service`

`bundle install`

Windows: Install cygwin or mingw

http://www.cygwin.com/install.html or http://mingw.org/wiki/Install_MinGW

Make sure [ImageMagick](http://www.imagemagick.org) is installed

`convert -version`

Check installation with `rspec`

### Execution

Development: `rerun --no-notify --pattern="*.rb" "puma -p 4000"`

Production: `puma -e production`

See `config/puma.rb` for puma settings

Heroku: `heroku create` only once & then `git push heroku master`

### Endpoints & API

#### `/thumbnail`

`GET /thumbnail?url=<url>&width=<width>&height=<height>`

The resizing logic is similar to [Cloudinary’s lpad cropping mode](https://cloudinary.com/documentation/image_transformations#lpad_limit_pad):
The image is scaled down to fill the given width and height while retaining the
original aspect ratio and with all of the original image visible. If the requested
dimensions are bigger than the original image&#39;s, the image doesn’t scale up. If
the proportions of the original image do not match the given width and height,
black padding is added to the image to reach the required size.
Both original & resized images are cached for further similar requests.

Parameters:

`url` - A url pointing to the origin image, must contain the URI scheme

`width` - Resized thumbnail width (int)

`height` - Resized thumbnail height (int)

`size` - In `<width>x<height>` format instead of `width` & `height` parameters

Optional parameters:

`reload` - Discard caches to re-download & re-process the image, default `false`

`gravity` - Specify resized image position on the canvas, default `center`

`background` - Padding background color, default `black`

Note: Currently, if optional settings are changed you should `reload`!

#### `/log`

`GET /log`

View last 500 log entries
