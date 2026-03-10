{ stdenv, fetchFromGitHub, darwin, gcc, make, apple-sdk_15 }:

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

  buildInputs = [ apple-sdk_15 ];

  NIX_LDFLAGS = "-F/System/Library/PrivateFrameworks -framework SkyLight";

  buildPhase = ''
    make
  '';

  installPhase = ''
    # Installation
    mkdir -p $out/bin
    cp ./bin/borders $out/bin/jankyBorders
  '';
}
