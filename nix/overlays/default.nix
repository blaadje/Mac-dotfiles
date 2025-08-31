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

  # Provide opencode as prebuilt release asset (v0.5.27) to avoid building from source.
  # opencode = super.stdenvNoCC.mkDerivation rec {
  #   pname = "opencode";
  #   version = "0.5.27";
  #
  #   # Archive GitHub Releases contenant le binaire `opencode` à la racine
  #   src = super.fetchzip {
  #     url =
  #       "https://github.com/sst/opencode/releases/download/v${version}/opencode-linux-x64.zip";
  #     sha256 = "sha256-/FURMcYorbutitimin4F2pqjm/jWwz0TMIM9DM+tju8=";
  #     # on ne retire pas la racine; la zip dépose `opencode` ici
  #     stripRoot = false;
  #   };
  #
  #   # Pas de compilation
  #   dontBuild = true;
  #   dontConfigure = true;
  #
  #   # Si le binaire est déjà exécutable et à la racine, c'est suffisant
  #   installPhase = ''
  #     mkdir -p $out/bin
  #     cp opencode $out/bin/
  #   '';
  #
  #   # Si jamais tu as un doute sur les libs dynamiques Linux,
  #   # tu peux activer autoPatchelfHook + zlib/glibc (décommenter ci-dessous) :
  #   #
  #   # nativeBuildInputs = [ super.autoPatchelfHook ];
  #   # buildInputs = [ super.stdenv.cc.cc super.zlib ];
  #
  #   meta = with super.lib; {
  #     description = "opencode CLI (prebuilt release)";
  #     homepage = "https://github.com/sst/opencode";
  #     license = licenses.mit;
  #     platforms = [ "x86_64-linux" ];
  #     mainProgram = "opencode";
  #   };
  # };
}
