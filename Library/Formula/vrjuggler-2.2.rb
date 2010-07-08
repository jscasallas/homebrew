require 'formula'

class Vrjuggler22 <Formula
  url 'http://vrjuggler.googlecode.com/files/vrjuggler-2.2.2-1-src.tar.bz2'
  version "2.2.2-1"
  md5 'bb8a57e88318d2f9c1bfc94a33ea3853'
  head 'http://vrjuggler.googlecode.com/svn/juggler/branches/2.2'
  homepage 'http://code.google.com/p/vrjuggler/'

  depends_on 'boost'
  depends_on 'cppdom'
  depends_on 'gmtl'
  depends_on 'flagpoll'
  depends_on 'freealut'

  def install
    args = ["--prefix=#{prefix}",
      "--with-boost=#{HOMEBREW_PREFIX}",
      "--with-alut=#{HOMEBREW_PREFIX}"]
    
    # For some reason, juggler fails to build nicely in parallel in any kind
    # of packinging-like setup
    ENV.deparallelize()
    
    # Make our local aclocal dir before autogen, to be safe and avoid errors
    system "mkdir -p #{prefix}/share/aclocal"
    
    ENV['ACLOCAL_FLAGS'] = "-I #{HOMEBREW_PREFIX}/share/aclocal -I #{prefix}/share/aclocal"
    ENV['FLAGPOLL_PATH'] = "#{HOMEBREW_PREFIX}/lib/flagpoll:#{HOMEBREW_PREFIX}/share/flagpoll:#{prefix}/lib/flagpoll:#{prefix}/share/flagpoll"
    ENV['AUTOCONF'] = "autoconf"
    ENV['AUTOHEADER'] = "autoheader"
    ENV['ACLOCAL'] = "aclocal-1.10"
    ENV['CC'] = "gcc"
    ENV['CXX'] = "g++"

    # Make the default Java location correct
    inreplace 'modules/tweek/java/tweek-base.sh.in' do |contents| 
      contents.gsub! /\/usr\/java/, '/usr'
    end

    system "./autogen.sh"
    
    # The prefix set here is immediately written to, so using the keg.
    system "./configure.pl", *args
    
    # setting the instprefix variable to put the homebrew prefix as the
    # libraries' "known root dir", while installing to the keg.

    # Make only the optimized shared libraries
    system "make", "opt-dso", "instprefix=#{HOMEBREW_PREFIX}", "DESTDIR=#{prefix}"
    
    # Install all available optimized libraries - in this case, only
    # shared available, static are peacefully ignored.
    system "make", "install-optim", "instprefix=#{HOMEBREW_PREFIX}", "DESTDIR=#{prefix}"
  end

  def caveats
    "VRJConfig.app and Tweek.app installed to #{prefix} - you may copy them to /Applications if you like."
  end
end
