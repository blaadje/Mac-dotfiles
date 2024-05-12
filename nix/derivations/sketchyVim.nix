{ stdenv, fetchzip }:

stdenv.mkDerivation rec {
  pname = "sketchyVim";
  version = "1.0.11";

  src = fetchzip {
    url =
      "https://github.com/FelixKratz/SketchyVim/releases/download/v${version}/bundle_${version}.tgz";
    hash = "sha256-DisrJarvGPLqQ+Lt3MQeTd5qKK/AS56Y4rHCykmZ680=";
  };

  dontBuild = true;

  installPhase = ''
    # Installation

    mkdir -p $out/bin
    cp svim $out/bin/svim
  '';
}
