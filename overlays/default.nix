self: super: {
  yabai = super.yabai.overrideAttrs (o: rec {
    version = "3.3.5";
    src = builtins.fetchTarball {
      url = "https://github.com/koekeishiya/yabai/releases/download/v${version}/yabai-v${version}.tar.gz";
      sha256 = "195n2sdw25iw4xvy3ydlxh0x2i39ni04bsqjl7wcf7dh57w10bj9";
    };

    installPhase = ''
      mkdir -p $out/bin
      mkdir -p $out/share/man/man1/
      cp ./archive/bin/yabai $out/bin/yabai
      cp ./archive/doc/yabai.1 $out/share/man/man1/yabai.1
    '';
  });
}