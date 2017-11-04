{ stdenv, fetchurl, ant, oraclejdk, gcc, libX11, libXt, libXcursor, libXxf86vm, libXrandr, libXext }:

stdenv.mkDerivation rec {
  name = "lwjgl-${version}";
  version = "2.9.2";

  src = fetchurl {
    url = "https://github.com/LWJGL/lwjgl/archive/lwjgl${version}.tar.gz";
    sha256 = "1m396ply3kspym3r00s1rbk77irn2f9vgr76xsy7272k649y3wky";
  };

  buildInputs = [ ant oraclejdk gcc libX11 libXt libXcursor libXxf86vm libXrandr libXext ];

  buildPhase = "mkdir -p bin && ant generate-all && ant compile && ant compile_native";

  installPhase = ''
    mkdir -p $out/lib
    cp bin/lwjgl/*.so $out/lib
  '';

  meta = with stdenv.lib; {
    description = "The Lightweight Java Game Library";
    longDescription = ''
      LWJGL is a Java library that enables cross-platform access to popular native APIs useful in the development of graphics (OpenGL), audio (OpenAL) and parallel computing (OpenCL) applications. This access is direct and high-performance, yet also wrapped in a type-safe and user-friendly layer, appropriate for the Java ecosystem.
    '';
    homepage = http://legacy.lwjgl.org/;
    license = licenses.bsd3;
    maintainers = with maintainers; [ pmiddend ];
    platforms = platforms.linux;
  };
}
