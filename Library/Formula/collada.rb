require 'formula'

class Collada < Formula
  url 'http://downloads.sourceforge.net/project/collada-dom/Collada%20DOM/Collada%20DOM%202.3/collada_dom-2.3.1-src.tgz'
  homepage 'http://www.collada.org/mediawiki/index.php/Portal:COLLADA_DOM'
  md5 'a74d19c1187806a713cec90c2f0f692c'

  depends_on 'pcre'
  depends_on 'boost'
  depends_on 'cmake'

  def install
    system "cmake . #{std_cmake_parameters}"
    system "make install"
  end
  def patches
    # Fix build of minizip: quoting arguments to cmake's add_definitions doesn't work the way they thought it did.
    return DATA
  end
end

__END__
diff --git a/CMakeLists.txt b/CMakeLists.txt
index 72b6deb..0c7f7ce 100644
--- a/CMakeLists.txt
+++ b/CMakeLists.txt
@@ -100,7 +100,7 @@ endif()
 
 if( APPLE OR ${CMAKE_SYSTEM_NAME} MATCHES "Darwin")
   # apple doesn't have 64bit versions of file opening functions, so add them
-  add_definitions("-Dfopen64=fopen -Dfseeko64=fseeko -Dfseek64=fseek -Dftell64=ftell -Dftello64=ftello")
+  add_definitions(-Dfopen64=fopen -Dfseeko64=fseeko -Dfseek64=fseek -Dftell64=ftell -Dftello64=ftello)
 endif()
 
 set(COLLADA_DOM_INCLUDE_INSTALL_DIR "include/collada-dom")
