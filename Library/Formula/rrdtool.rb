require 'formula'

class Rrdtool <Formula
  url 'http://oss.oetiker.ch/rrdtool/pub/rrdtool-1.4.3.tar.gz'
  homepage 'http://oss.oetiker.ch/rrdtool/'
  md5 '492cf946c72f85987238faa2c311b7bb'

  depends_on 'pkg-config'
  depends_on 'glib'
  depends_on 'gettext'
  depends_on 'libxml2'
  depends_on 'expat'
  depends_on 'pango'
  depends_on 'libpng'
  depends_on 'intltool'

  def install
    system "./configure", "--disable-dependency-tracking",
                          "--prefix=#{prefix}",
                          "--enable-perl-site-install", "--enable-ruby-site-install",
                          # Installing directly into Homebrew's Python's site-packages
                          # can break things, so we disable this for now.
                          # TODO: how to build Python support w/o installing it.
                          "--disable-python"
    system "make install"
  end
end
