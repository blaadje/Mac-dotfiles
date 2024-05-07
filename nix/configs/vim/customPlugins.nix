{ buildVimPlugin, fetchFromGitHub }:

{
  move-nvim = buildVimPlugin {
    name = "move.nvim";
    version = "2024-05-07";
    src = fetchFromGitHub {
      owner = "fedepujol";
      repo = "move.nvim";
      rev = "cccbd4ea9049ca5f99f025ffaddb7392359c7d6a";
      hash = "sha256-aJi7r9yPdQyH6i8EtQzKdRhEQ3SLz32oqcN0tf2qRZA=";
    };
  };
  telescope-recent-files-nvim = buildVimPlugin {
    name = "telescope-recent-files";
    version = "2024-05-07";
    src = fetchFromGitHub {
      owner = "mollerhoj";
      repo = "telescope-recent-files.nvim";
      rev = "9f8cb7d22b999346ce819390e75a509e4048f4de";
      hash = "sha256-+9BjCfOQTbJyOPIATHak7B8qxn7n6BfJVNT3KRhxLgk=";
    };
  };

}
