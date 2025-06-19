{ pkgs, config, ... }:

let
  # setup (identique à ce que tu as)
  custom-plugins = pkgs.callPackage ./customPlugins.nix {
    inherit (pkgs.vimUtils) buildVimPlugin;
    inherit (pkgs) fetchFromGitHub;
  };

  plugins = pkgs.vimPlugins // custom-plugins;
  folderPath = builtins.toString ./.;

  myVimPlugins = with plugins; [
    base16-nvim
    vim-nix
    nvim-treesitter.withAllGrammars
    rainbow-delimiters-nvim
    indent-blankline-nvim
    yanky-nvim
    telescope-nvim
    nvim-web-devicons
    mason-nvim
    mason-lspconfig-nvim
    nvim-lspconfig
    nvim-cmp
    cmp-nvim-lsp
    neoformat
    gitsigns-nvim
    nvim-ts-autotag
    nvim-autopairs
    luasnip
    lualine-nvim
    telescope-recent-files-nvim
    move-nvim
    # feline-nvim - deprecated
    vim-devicons
    nvim-colorizer-lua
    trouble-nvim
    nvim-tree-lua
    vim-cursorword
  ];
in {
  # options = {
  #   number = true;
  #   relativenumber = true;
  #   shiftwidth = 2;
  #   numberwidth = 4;
  #   scrolloff = 999;
  # };
  extraPlugins = myVimPlugins;

  extraConfigLua = ''
    package.path = package.path .. ";${folderPath}/?.lua"

    require('base16-colorscheme').setup({
      base00 = "#${config.colorScheme.palette.base00}",
      base01 = "#${config.colorScheme.palette.base01}",
      base02 = "#${config.colorScheme.palette.base02}",
      base03 = "#${config.colorScheme.palette.base03}",
      base04 = "#${config.colorScheme.palette.base04}",
      base05 = "#${config.colorScheme.palette.base05}",
      base06 = "#${config.colorScheme.palette.base06}",
      base07 = "#${config.colorScheme.palette.base07}",
      base08 = "#${config.colorScheme.palette.base08}",
      base09 = "#${config.colorScheme.palette.base09}",
      base0A = "#${config.colorScheme.palette.base0A}",
      base0B = "#${config.colorScheme.palette.base0B}",
      base0C = "#${config.colorScheme.palette.base0C}",
      base0D = "#${config.colorScheme.palette.base0D}",
      base0E = "#${config.colorScheme.palette.base0E}",
      base0F = "#${config.colorScheme.palette.base0F}",
    })

    require("init")
  '';

}
