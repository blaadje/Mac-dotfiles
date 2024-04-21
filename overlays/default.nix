self: super: {
  # JankyBorders = super.JankyBorders.overrideAttrs (oldAttrs: rec {
  #   version = "1.0.0"; # Mettez à jour cette version si nécessaire

  #   src = super.fetchFromGitHub {
  #     owner = "FelixKratz";
  #     repo = "yabai";
  #     rev =
  #       "7787e87ae20603b845f5c0dda018135934f277be"; # ou le hash du commit que vous voulez télécharger
  #     sha256 =
  #       "1szyjcwkhn2wbrcfhh9lh5bnfm1cavxrx6xj4q7521z3zj29a9kf"; # Mettez à jour ce sha256 si nécessaire
  #   };

  #   buildInputs = [ super.Cocoa super.SkyLight super.ScriptingBridge ];

  #   # Supprimez la ligne suivante si Carbon est disponible dans votre environnement Nix
  #   postPatch = "sed -i 's/-framework Carbon//g' makefile";

  #   # Cette étape d'installation est basée sur ce que vous avez fourni précédemment.
  #   # Si le paquet n'installe pas correctement les fichiers, cela pourrait nécessiter des ajustements.
  #   installPhase = ''
  #     runHook preInstall
  #     mkdir -p $out
  #     cp -r ./bin $out
  #     installManPage ./doc/yabai.1
  #     runHook postInstall
  #   '';
  # });

  yabai = super.yabai.overrideAttrs (o: rec {
    version = "7.1.0";
    src = super.fetchzip {
      url =
        "https://github.com/koekeishiya/yabai/releases/download/v${version}/yabai-v${version}.tar.gz";
      hash = "sha256-88Sh2nizAQ0a0cnlnrkhb5x3VjHa372HhjHlmNjGdQ4=";
    };
  });

  # src = builtins.fetchTarball {
  #   url =
  #     "https://github.com/koekeishiya/yabai/releases/download/v${version}/yabai-v${version}.tar.gz";
  #   sha256 = "1szyjcwkhn2wbrcfhh9lh5bnfm1cavxrx6xj4q7521z3zj29a9kf";
  # };

  #  nerdfonts = super.nerdfonts.override { fonts = [ "Agave" ]; };

  # yarn = super.yarn.override {
  # nodejs = null;

  # nodejs = super.nodejs-14_x.override {
  #   enableNpm = false;
  # };
  # };

  # yarn = super.yarn.overrideAttrs (o: rec {

  #   nodejs = super.pkgs.nodejs-16_x;
  # });

  # alacritty = super.alacritty.overrideAttrs (o: rec {
  #   version = "0.12.3";

  #   cargoHash = "";

  #   src = builtins.fetchurl {
  #     url =
  #       "https://github.com/alacritty/alacritty/archive/refs/tags/v${version}.tar.gz";
  #     sha256 = "1ar8dggk9divhh0y1zh0lj2y3s6daw5y6hfclcp1nmhyjyfn69bq";
  #   };

  #   # postPatch = o.postPatch or "" + ''
  #   #   substituteInPlace script_name_that_generates_man --replace "gzip extra/alacritty-msg.man" "true"
  #   # '';

  #   doCheck = false;

  #   cargoDeps = o.cargoDeps.overrideAttrs (_: {
  #     name = "alacritty-vendor.tar.gz";
  #     inherit src;
  #     outputHash = "sha256-4GiFLw4MTG4/3JiJgotBGK7x6YS4vlJsqNA0IRYf954=";
  #   });
  # });

  # spacebar = super.spacebar.overrideAttrs (o: rec {
  #   src = builtins.fetchTarball {
  #     url = "https://github.com/cmacrae/spacebar/releases/download/v1.4.0/spacebar-v1.4.0.tar.gz";
  #     sha256 = "1wfqgp8h9x9d6vixmqs9xkkqx67varhh4nsy1gwa8bf1m6qaf7nl";
  #   };

  #   installPhase = ''
  #     mkdir -p $out/bin
  #     echo 'COUCOUCOUCOUCOU'
  #     cp spacebar $out/bin/spacebar

  #   '';
  # });

  # alacritty = super.pkgs.rustPlatform.buildRustPackage rec {
  #   version = "0.10.1";
  #   pname = "alacritty";

  #   src = super.fetchFromGitHub {
  #     owner = "alacritty";
  #     repo = pname;
  #     rev = "refs/tags/v${version}";
  #     sha256 = "sha256-Q/ulRgU6zNLRZUjL83O/Krx85voPWZPZDo65CLp/aOg=";
  #   };

  #   cargoSha256 = "sha256-S1V8hDuzp4sf6945gqs8QNVdu8jwPGVYjVbV6EY28Hk=";
  #   cargoHash = "sha256-S1V8hDuzp4sf6945gqs8QNVdu8jwPGVYjVbV6EY28Hk=";
  # };

  # alacritty = super.alacritty.overrideAttrs (o: rec {
  # });
}
