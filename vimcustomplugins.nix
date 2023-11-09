{ buildVimPlugin }:

{
  material-vim = buildVimPlugin {
    name = "material-vim";
    src = builtins.fetchTarball {
      name   = "material-vim-2020-10-21";
      url    = "https://github.com/kaicataldo/material.vim/archive/7a725ae.tar.gz";
      sha256 = "0nd3qvwpcbvawc6zaczzzyq0mxgfn7bfv36yw05f03rqipgfw6fn";
    };
  };

}