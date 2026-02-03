{ stdenv, fetchFromGitHub, darwin, gcc, make }:

stdenv.mkDerivation rec {
  pname = "jankyBorders";
  version = "1.8.4";

  src = fetchFromGitHub {
    owner = "FelixKratz";
    repo = "JankyBorders";
    rev = "v${version}";
    sha256 = "sha256-31Er+cUQNJbZnXKC6KvlrBhOvyPAM7nP3BaxunAtvWg=";
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
