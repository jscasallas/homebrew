require 'formula'

class Flusspferd < Formula
  url 'https://github.com/Flusspferd/flusspferd/tarball/v0.9'
  homepage 'http://flusspferd.github.com/'
  md5 '8d839b9ab25e1f3fcb9c0e48fb3538b9'

  depends_on 'cmake' => :build
  depends_on 'arabica'
  depends_on 'gmp'
  depends_on 'boost'
  depends_on 'spidermonkey'

  fails_with_llvm

  #Fix CMakeModules/FindSpidermonkey.cmake to be able to find SM 1.8.5
  def patches
    "https://raw.github.com/gist/1347323/flusspferd-cmake_find_spidermonkey1.8.5.patch"
  end

  def install
    system "cmake -H. -Bbuild #{std_cmake_parameters}"
    system "make install"
  end
end
