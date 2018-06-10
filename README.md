Sinatra/ImageMagic thumbnail service
=====================

Small, simple and fast thumbnail service, written in Ruby

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

### Endpoints & API

#### `/thumbnail`

`GET /thumbnail?url=&lt;url&gt;&amp;width=&lt;width&gt;&amp;height=&lt;height&gt;`

The resizing logic is similar to [Cloudinary’s lpad cropping mode](https://cloudinary.com/documentation/image_transformations#lpad_limit_pad):
The image is scaled down to fill the given width and height while retaining the
original aspect ratio and with all of the original image visible. If the requested
dimensions are bigger than the original image&#39;s, the image doesn’t scale up. If
the proportions of the original image do not match the given width and height,
black padding is added to the image to reach the required size.
Both original & resized images are cached for further similar requests.

Parameters:

`url` - A url pointing to the origin image, must contain the URI scheme

`width`:Integer - Resized thumbnail width

`height`:Integer - Resized thumbnail height

`size` - In `&lt;width&gt;&amp;x&lt;height&gt;` format instead of `width` & `height` parameters

Optional parameters:

`reload` - Discard caches to re-download & re-process the image, default `false`

`gravity` - Specify resized image position on the canvas, default `center`

`background` - Padding background color, default `black`

Note: Currently, if optional settings are changed you should `reload`!

#### `/log`

`GET /log`

View last 500 log entries
