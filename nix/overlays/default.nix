self: super: {
  ccusage = super.stdenv.mkDerivation rec {
    pname = "ccusage";
    version = "15.5.0";

    src = super.fetchurl {
      url = "https://registry.npmjs.org/ccusage/-/ccusage-${version}.tgz";
      sha256 = "sha256-pb0dlxYOSnqJkZknAKozeOdBH3raVOoqHKGWkRX/Lio=";
    };

    nativeBuildInputs = with super; [ nodejs ];

    unpackPhase = ''
      tar -xzf $src --strip-components=1
    '';

    installPhase = ''
      mkdir -p $out/lib/node_modules/ccusage
      cp -r * $out/lib/node_modules/ccusage/
      mkdir -p $out/bin

      # Create wrapper script
      cat > $out/bin/ccusage << EOF
      #!/usr/bin/env bash
      exec ${super.nodejs}/bin/node $out/lib/node_modules/ccusage/dist/index.js "\$@"
      EOF
      chmod +x $out/bin/ccusage
    '';

    meta = with super.lib; {
      description = "A tool for Claude Code usage analysis";
      homepage = "https://github.com/ryoppippi/ccusage";
      license = licenses.mit;
      platforms = platforms.unix;
      maintainers = [ ];
    };
  };
}
