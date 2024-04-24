{ pkgs, ... }:
with pkgs;
let
  custom-plugins =
    callPackage ./vimcustomplugins.nix { inherit (vimUtils) buildVimPlugin; };
  plugins = vimPlugins // custom-plugins;

  myVimPlugins = with plugins; [
    nvim-base16
    fugitive
    material-vim
    indent-blankline-nvim
    vim-devicons
    nerdtree
    ghc-mod-vim
    haskell-vim
    LanguageClient-neovim
    nerdcommenter
    neomake
    polyglot
    ranger-vim
    rust-vim
    SpaceCamp
    syntastic
    vim-vue
    ctrlp-vim
    vim-nix
    vim-colorschemes
    vim-airline
    vim-airline-themes
    vim-autoformat
    YouCompleteMe
  ];
in {
  options = {
    number = true; # Show line numbers
    relativenumber = false; # Show relative line numbers

    shiftwidth = 2; # Tab width should be 2
  };
  extraPlugins = myVimPlugins;
  extraConfigLua = ''
    require("ibl").setup()
  '';
}
