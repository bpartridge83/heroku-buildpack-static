# This is copied out of the ngx_mruby repository in order to allow us to remove
# the redis gem that is bundled by default (and won't compile on our setups).
#
# Beyond that, this is some build config. It controls which mruby gems get bundled
# into the MRuby instance built into nginx.
#
# More detail can be found in the ngx_mruby wiki here:
# https://github.com/matsumoto-r/ngx_mruby/wiki/Install#1-download

MRuby::Build.new do |conf|

  toolchain :gcc

  conf.gembox 'full-core'

  conf.cc do |cc|
    cc.flags << ENV['NGX_MRUBY_CFLAGS'] if ENV['NGX_MRUBY_CFLAGS']
  end

  # Recommended for ngx_mruby
  #
  # These are gems that ngx_mruby recommends bundling with the build in order to
  # provide useful/expected features
  #
  conf.gem :github => 'iij/mruby-io'
  conf.gem :github => 'iij/mruby-env'
  conf.gem :github => 'iij/mruby-dir'
  conf.gem :github => 'iij/mruby-digest'
  conf.gem :github => 'iij/mruby-process'
  conf.gem :github => 'iij/mruby-pack'
  conf.gem :github => 'iij/mruby-socket'
  conf.gem :github => 'mattn/mruby-json'
  conf.gem :github => 'mattn/mruby-onig-regexp'
  conf.gem :github => 'matsumoto-r/mruby-sleep'
  conf.gem :github => 'matsumoto-r/mruby-userdata'
  conf.gem :github => 'matsumoto-r/mruby-uname'
  conf.gem :github => 'matsumoto-r/mruby-mutex'
  conf.gem :github => 'matsumoto-r/mruby-cache'

  #
  # ngx_mruby extensions
  #
  # These are two gems with the source bundled with the ngx_mruby repository.
  # They add some useful extensions to the core ngx_mruby featureset, but are
  # opt-in when building to reduce overhead if unrequired. Left in our build as
  # they seem innocuous and may be useful in the future.
  #
  conf.gem './mrbgems/ngx_mruby_mrblib'
  conf.gem './mrbgems/rack-based-api'
end
