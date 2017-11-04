{ stdenv, fetchurl, ant, openjdk, gcc }:

stdenv.mkDerivation rec {
  name = "libgdx-${version}";
  version = "1.9.6";

  src = fetchurl {
    url = "https://github.com/libgdx/libgdx/archive/${version}.tar.gz";
    sha256 = "1lxky0cz4qjpw4x06cf2kpa00cj0n0jp3vfsp67jy1d42dqyshgb";
  };

  buildInputs = [ ant openjdk gcc ];

  buildPhase = "find . -name '*.so' -delete && cd gdx/jni && ant -f build-linux64.xml && cd ../../extensions/gdx-box2d/gdx-box2d/jni && ant -f build-linux64.xml && cd ../../../../";

  installPhase = ''
    mkdir -p $out/lib
    cp gdx/libs/linux64/*.so $out/lib
    cp extensions/gdx-box2d/gdx-box2d/libs/linux64/*.so $out/lib
  '';

  meta = with stdenv.lib; {
    description = "Desktop/Android/BlackBerry/iOS/HTML5 Java game development framework";
    longDescription = '''';
    homepage = http://libgdx.badlogicgames.com/;
    license = licenses.asl20;
    maintainers = with maintainers; [ pmiddend ];
    platforms = platforms.linux;
  };
}
