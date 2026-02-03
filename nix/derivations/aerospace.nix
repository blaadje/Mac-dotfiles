{ stdenv, fetchzip, installShellFiles }:

stdenv.mkDerivation rec {
  pname = "aerospace";
  version = "0.20.2-Beta";

  src = fetchzip {
    url = "https://github.com/nikitabobko/AeroSpace/releases/download/v${version}/AeroSpace-v${version}.zip";
    sha256 = "sha256-1v72aklb0pc399k1l59s3shivbc9iw090x26j1jg6p7wrns8f99z";
    stripRoot = false;
  };

  nativeBuildInputs = [ installShellFiles ];

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

  meta = with stdenv.lib; {
    description = "AeroSpace is an i3-like tiling window manager for macOS";
    homepage = "https://github.com/nikitabobko/AeroSpace";
    license = licenses.mit;
    platforms = platforms.darwin;
    mainProgram = "aerospace";
  };
}
