self: super: {
  # Override aerospace with custom version
  aerospace = super.stdenv.mkDerivation rec {
    pname = "aerospace";
    version = "0.20.3-Beta";

    src = super.fetchzip {
      url =
        "https://github.com/nikitabobko/AeroSpace/releases/download/v${version}/AeroSpace-v${version}.zip";
      sha256 = "sha256-wrBcslp1W/lOmudMcW+SREL9LZY+wTwidh6Hot5ShGE=";
    };

    nativeBuildInputs = [ super.installShellFiles ];

    installPhase = ''
      runHook preInstall

      mkdir -p $out/Applications
      cp -r AeroSpace.app $out/Applications/

      mkdir -p $out/bin
      cp bin/aerospace $out/bin/aerospace

      # Install man pages
      mkdir -p $out/share/man
      cp -r manpage/* $out/share/man/

      # Install shell completions
      installShellCompletion --bash shell-completion/bash/aerospace
      installShellCompletion --zsh shell-completion/zsh/_aerospace
      installShellCompletion --fish shell-completion/fish/aerospace.fish

      runHook postInstall
    '';

    meta = with super.lib; {
      description = "AeroSpace is an i3-like tiling window manager for macOS";
      homepage = "https://github.com/nikitabobko/AeroSpace";
      license = licenses.mit;
      platforms = platforms.darwin;
      mainProgram = "aerospace";
    };
  };

  yabai = super.yabai.overrideAttrs (finalAttrs: old: {
    version = "7.1.23";
    passthru = old.passthru // {
      sources = old.passthru.sources // {
        "aarch64-darwin" = super.fetchzip {
          url =
            "https://github.com/asmvik/yabai/releases/download/v${finalAttrs.version}/yabai-v${finalAttrs.version}.tar.gz";
          hash = "sha256-p8LHuAhmkKNPkRNIw4NHpAA+/oQPMI34H21mlUiwK+M=";
        };
      };
    };
    src = finalAttrs.passthru.sources.${super.stdenv.hostPlatform.system};
  });

  rift = super.rustPlatform.buildRustPackage rec {
    pname = "rift";
    version = "0-unstable-2026-04-15";

    src = super.fetchFromGitHub {
      owner = "acsandmann";
      repo = "rift";
      rev = "27f5f00e7f40e7ba1b01cd25721b2545f255d42f";
      hash = "sha256-JH6G5PWaR8Kw/hE4Rb6RvrkvBX6Hn4u1g+OFXE2Mmkc=";
    };

    cargoLock = {
      lockFile = src + "/Cargo.lock";
      outputHashes = {
        "continue-0.1.1" =
          "sha256-8S+gPfz6CtzIKsGh9wg3CevMdNA9V+KOyHR9F9DlVcw=";
        "dispatchr-1.0.0" =
          "sha256-Df6PdDA5bpmy2P30vGdad+EiHJiANmHrRF2q75Uegik=";
      };
    };

    buildInputs = [ super.apple-sdk_15 ];

    # Link against macOS private frameworks
    NIX_LDFLAGS =
      "-F/System/Library/PrivateFrameworks -framework SkyLight -framework MultitouchSupport";

    # Use default cargoInstallHook (handles cross-compile target paths)

    meta = with super.lib; {
      description =
        "Rift is a fast, configurable tiling window manager for macOS";
      homepage = "https://github.com/acsandmann/rift";
      license = licenses.mit;
      platforms = platforms.darwin;
      mainProgram = "rift";
    };
  };

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
