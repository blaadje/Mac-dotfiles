{ stdenv, fetchFromGitHub, darwin, gcc, make }:

stdenv.mkDerivation rec {
  pname = "jankyBorders";
  version = "1.6.0";

  src = fetchFromGitHub {
    owner = "FelixKratz";
    repo = "JankyBorders";
    rev = "v${version}";
    sha256 = "sha256-DX1d228UCOI+JU+RxenhiGyn3AiqpsGe0aCtr091szs=";
  };

  nativeBuildInputs = [ gcc ];

  buildInputs =
    [ darwin.apple_sdk.frameworks.AppKit darwin.apple_sdk.frameworks.SkyLight ];

  buildPhase = ''
    make
  '';

  installPhase = ''
    # Installation
    mkdir -p $out/bin
    cp ./bin/borders $out/bin/jankyBorders
  '';
}
