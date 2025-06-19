{ config }:
let
  colors = import ./colors.nix { inherit config; };
  editor = import ./editor.nix;
in editor // colors // {
  "update.mode" = "none";

  # languages
  "deno.enablePaths" = [ "./supabase/functions" ];
  "deno.importMap" = "./supabase/import_map.json";

  "[javascript]" = { "editor.defaultFormatter" = "esbenp.prettier-vscode"; };
  "[typescriptreact]" = {
    "editor.defaultFormatter" = "esbenp.prettier-vscode";
  };
  "editor.defaultFormatter" = "esbenp.prettier-vscode";
  "[scss]" = { "editor.defaultFormatter" = "esbenp.prettier-vscode"; };
  "[nix]" = { "editor.defaultFormatter" = "brettm12345.nixfmt-vscode"; };

  "eslint.format.enable" = true;
  "eslint.debug" = true;
  "eslint.validate" = [ "javascript" "typescript" "typescriptreact" "vue" ];
  "stylelint.validate" = [ "css" "scss" ];

  "workbench.activityBar.visible" = false;
  "workbench.activityBar.location" = "hidden";
  "workbench.tree.renderIndentGuides" = "none";
  "workbench.statusBar.visible" = true;
  "workbench.editor.showTabs" = false;
  "workbench.layoutControl.enabled" = false;
  "workbench.startupEditor" = "none";
  "workbench.tips.enabled" = false;

  "explorer.confirmDragAndDrop" = false;
  "explorer.confirmDelete" = false;
  "explorer.compactFolders" = false;

  "breadcrumbs.enabled" = false;
  "git.decorations.enabled" = true;
  "files.insertFinalNewline" = true;
  "extensions.ignoreRecommendations" = false;

  "window.titleBarStyle" = "native";
  "window.menuBarVisibility" = "toggle";
  "window.commandCenter" = false;

  "apc.electron" = {
    titleBarStyle = "hidden";
    trafficLightPosition = {
      x = 70;
      y = 70000;
    };
  };
  "apc.listRow" = {
    lists = [ "explorer-folders-view" "quick-input-list" "results" ];
    height = 30;
  };
  "apc.stylesheet" = {
    ".title-actions" = "display: none !important";
    ".quick-input-widget.show-file-icons, .editor-widget.find-widget" =
      "box-shadow: none !important";
    ".filematch .monaco-icon-label:before, .custom-list-row.results .monaco-list-row .monaco-icon-label:before" =
      "background-position: 0 bottom !important";
    ".filematch .monaco-count-badge" = "padding: 5px 6px 0 6px !important";
    ".sidebar .title-label" = "padding: 0 !important";
    ".monaco-workbench .monaco-list:not(.element-focused):focus:before" =
      "outline: none !important";
    ".sidebar" = "border: none !important";
    ".monaco-editor .cursors-layer .cursor" =
      "background-image: linear-gradient(135deg, #67D0FF 10%, #C45DFF 100%)";
    ".quick-input-list-row div" =
      "display: flex !important; align-items: center !important";
    ".panel .composite.title" = "visibility: hidden !important";
    ".title.show-file-icons .label-container .monaco-icon-label.file-icon" =
      "padding-bottom: 6px !important";
    ".sidebar .title-label h2" = "line-height: 2.8 !important";
    ".monaco-editor .scroll-decoration" = "display: none !important";
    ".monaco-scrollable-element > .shadow.top" = "display: none !important";
  };

  "animations.Install-Method" = "Apc Customize UI++";
  "extensions.experimental.affinity" = { "vscodevim.vim" = 1; };

  # vim
  "vim.easymotion" = true;
  "vim.highlightedyank.enable" = true;
  "vim.incsearch" = true;
  "vim.useSystemClipboard" = false;
  "vim.useCtrlKeys" = true;
  "vim.hlsearch" = true;
  "vim.insertModeKeyBindings" = [{
    before = [ "h" "h" ];
    after = [ "<Esc>" ];
  }];
  "vim.leader" = ";";
}
