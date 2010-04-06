require 'formula'

class Vrjuggler22 <Formula
#  url 'http://downloads.sourceforge.net/project/vrjuggler/VR%20Juggler/2.2.1/vrjuggler-2.2.1-1-src.tar.bz2'
  head 'http://vrjuggler.googlecode.com/svn/juggler/branches/2.2'
  homepage 'http://code.google.com/p/vrjuggler/'
  md5 ''

 depends_on 'boost'
 depends_on 'cppdom'
 depends_on 'gmtl'
 depends_on 'flagpoll'

	def install
		ENV['ACLOCAL_FLAGS'] = "-I #{HOMEBREW_PREFIX}/share/aclocal"
		ENV['FLAGPOLL_PATH'] = "#{HOMEBREW_PREFIX}/lib/flagpoll:#{HOMEBREW_PREFIX}/share/flagpoll"
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
		system "./configure.pl", "--prefix=#{prefix}", "--with-boost=#{HOMEBREW_PREFIX}"
		#, "--with-macosx-sdk=/Developer/SDKs/MacOSX#{MACOS_VERSION}.sdk/"  "--with-abi=DARWIN_i386", 
		system "make", "optim"
		system "make", "install-optim"
	end

	def caveats
		"VRJConfig.app and Tweek.app installed to #{prefix} - you may copy them to /Applications if you like."
	end
end
