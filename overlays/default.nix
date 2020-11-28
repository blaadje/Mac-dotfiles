self: super: {
  yabai = super.yabai.overrideAttrs (o: {
    src = super.fetchFromGitHub {
      owner = "koekeishiya";
      repo = "yabai";
      rev = "v3.3.4";
      sha256 = "1pvyjdxgy7yxxz4x87f8an0dlxvxbnmv5kya8hkzw2na453ihvab";
    };
  });
}