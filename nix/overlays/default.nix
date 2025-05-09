self: super: {
  yabai = super.yabai.overrideAttrs (o: rec {
    version = "7.1.0";

    src = super.fetchzip {
      url =
        "https://github.com/koekeishiya/yabai/releases/download/v${version}/yabai-v${version}.tar.gz";
      hash = "sha256-88Sh2nizAQ0a0cnlnrkhb5x3VjHa372HhjHlmNjGdQ4=";
    };
  });

  ghostscript = super.ghostscript.overrideAttrs (oldAttrs: {
    preConfigure = oldAttrs.preConfigure or "" + ''
      # Ajout du chemin pour Darwin
      ${super.lib.optionalString super.stdenv.hostPlatform.isDarwin ''
        export DARWIN_LDFLAGS_SO_PREFIX=$out/lib/
      ''}
    '';

    buildPhase = oldAttrs.buildPhase or "" + ''
      # Application des flags spécifiques à Darwin si nécessaire
      ${super.lib.optionalString super.stdenv.hostPlatform.isDarwin ''
        export LDFLAGS="$LDFLAGS -headerpad_max_install_names"
      ''}
    '';
  });



  # karabiner-elements = super.karabiner-elements.overrideAttrs (o: rec {
  #   version = "14.11.0";

  #   src = super.fetchurl {
  #     url =
  #       "https://github.com/pqrs-org/Karabiner-Elements/releases/download/v${version}/Karabiner-Elements-${version}.dmg";
  #     sha256 = "sha256-InuSfXbaSYsncq8jVO15LbQmDTguRHlOiE/Pj5EfX5c=";
  #   };
  # });

  # sketchybar = super.sketchybar.overrideAttrs (o: rec { version = "2.21.0"; });
}
