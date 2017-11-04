self: super:

{
  lwjgl = super.callPackage ./pkgs/lwjgl.nix {
    stdenv = self.stdenv;
  };

  gdx = super.callPackage ./pkgs/gdx.nix {
    stdenv = self.stdenv;
  };
}
