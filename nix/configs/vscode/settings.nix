{ config }: {
  # editor settings
  "editor.formatOnSave" = true;
  "editor.minimap.enabled" = false;
  "editor.fontSize" = 14;
  "editor.codeActionsOnSave" = { "source.addMissingImports" = "always"; };
  "editor.lineHeight" = 24;
  "editor.linkedEditing" = true;
  "editor.suggest.insertMode" = "replace";
  "editor.codeActionsOnSave" = {
    "source.fixAll.eslint" = true;
    "source.fixAll.stylelint" = true;
  };
  "editor.tabSize" = 2;
  "editor.lineNumbers" = "relative";
  "vim.highlightedyank.enable" = true;
  "editor.renderLineHighlight" = "all";
  # theme
  "workbench.activityBar.visible" = false;

  "editor.defaultFormatter" = "dbaeumer.vscode-eslint";
  "eslint.format.enable" = true;
  "vim.leader" = ";";
  "[javascript]" = { "editor.defaultFormatter" = "dbaeumer.vscode-eslint"; };
  "[typescriptreact]" = {
    "editor.defaultFormatter" = "dbaeumer.vscode-eslint";
  };
  "[scss]" = { "editor.defaultFormatter" = "esbenp.prettier-vscode"; };
  "eslint.debug" = true;
  "eslint.validate" = [ "javascript" "typescript" "typescriptreact" "vue" ];
  "stylelint.validate" = [ "css" "scss" ];
  "editor.renderWhitespace" = "none";
  "[nix]" = { "editor.defaultFormatter" = "brettm12345.nixfmt-vscode"; };
  "workbench.colorCustomizations" = {
    "foreground" = "#${config.colorScheme.palette.base05}";
    "disabledForeground" = "#${config.colorScheme.palette.base04}";
    "widget.shadow" = "#${config.colorScheme.palette.base00}";
    "selection.background" = "#${config.colorScheme.palette.base0D}";
    "descriptionForeground" = "#${config.colorScheme.palette.base03}";
    "errorForeground" = "#${config.colorScheme.palette.base08}";
    "icon.foreground" = "#${config.colorScheme.palette.base04}";

    "textBlockQuote.background" = "#${config.colorScheme.palette.base01}";
    "textBlockQuote.border" = "#${config.colorScheme.palette.base0D}";
    "textCodeBlock.background" = "#${config.colorScheme.palette.base00}";
    "textLink.activeForeground" = "#${config.colorScheme.palette.base0C}";
    "textLink.foreground" = "#${config.colorScheme.palette.base0D}";
    "textPreformat.foreground" = "#${config.colorScheme.palette.base0D}";
    "textSeparator.foreground" = "#f0f";

    "toolbar.hoverBackground" = "#${config.colorScheme.palette.base02}";
    "toolbar.activeBackground" = "#${config.colorScheme.palette.base03}";

    "button.background" = "#${config.colorScheme.palette.base0D}";
    "button.foreground" = "#${config.colorScheme.palette.base07}";
    "button.hoverBackground" = "#${config.colorScheme.palette.base04}";
    "button.secondaryForeground" = "#${config.colorScheme.palette.base07}";
    "button.secondaryBackground" = "#${config.colorScheme.palette.base0E}";
    "button.secondaryHoverBackground" = "#${config.colorScheme.palette.base04}";
    "checkbox.background" = "#${config.colorScheme.palette.base00}";
    "checkbox.foreground" = "#${config.colorScheme.palette.base05}";

    "dropdown.background" = "#${config.colorScheme.palette.base00}";
    "dropdown.listBackground" = "#${config.colorScheme.palette.base00}";
    "dropdown.foreground" = "#${config.colorScheme.palette.base05}";

    "input.background" = "#${config.colorScheme.palette.base00}";
    "input.foreground" = "#${config.colorScheme.palette.base05}";
    "input.placeholderForeground" = "#${config.colorScheme.palette.base03}";
    "inputOption.activeBackground" = "#${config.colorScheme.palette.base02}";
    "inputOption.activeBorder" = "#${config.colorScheme.palette.base09}";
    "inputOption.activeForeground" = "#${config.colorScheme.palette.base05}";
    "inputValidation.errorBackground" = "#${config.colorScheme.palette.base08}";
    "inputValidation.errorForeground" = "#${config.colorScheme.palette.base05}";
    "inputValidation.errorBorder" = "#${config.colorScheme.palette.base08}";
    "inputValidation.infoBackground" = "#${config.colorScheme.palette.base0D}";
    "inputValidation.infoForeground" = "#${config.colorScheme.palette.base05}";
    "inputValidation.infoBorder" = "#${config.colorScheme.palette.base0D}";
    "inputValidation.warningBackground" =
      "#${config.colorScheme.palette.base0A}";
    "inputValidation.warningForeground" =
      "#${config.colorScheme.palette.base05}";
    "inputValidation.warningBorder" = "#${config.colorScheme.palette.base0A}";

    "scrollbar.shadow" = "#${config.colorScheme.palette.base01}";
    "scrollbarSlider.activeBackground" =
      "#${config.colorScheme.palette.base04}";
    "scrollbarSlider.background" = "#${config.colorScheme.palette.base02}";
    "scrollbarSlider.hoverBackground" = "#${config.colorScheme.palette.base03}";

    "badge.background" = "#${config.colorScheme.palette.base00}";
    "badge.foreground" = "#${config.colorScheme.palette.base05}";

    "progressBar.background" = "#${config.colorScheme.palette.base03}";

    "list.activeSelectionBackground" = "#${config.colorScheme.palette.base01}";
    "list.inactiveSelectionBackground" =
      "#${config.colorScheme.palette.base01}";
    "list.focusBackground" = "#${config.colorScheme.palette.base01}";
    "list.hoverBackground" = "#${config.colorScheme.palette.base01}";

    "list.activeSelectionForeground" = "#${config.colorScheme.palette.base05}";
    "list.dropBackground" = "#${config.colorScheme.palette.base07}";
    "list.focusForeground" = "#${config.colorScheme.palette.base05}";
    "list.highlightForeground" = "#${config.colorScheme.palette.base07}";
    "list.hoverForeground" = "#${config.colorScheme.palette.base05}";
    "list.inactiveSelectionForeground" =
      "#${config.colorScheme.palette.base05}";
    "list.inactiveFocusBackground" = "#${config.colorScheme.palette.base02}";
    "list.invalidItemForeground" = "#${config.colorScheme.palette.base08}";
    "list.errorForeground" = "#${config.colorScheme.palette.base08}";
    "list.warningForeground" = "#${config.colorScheme.palette.base0A}";
    "listFilterWidget.background" = "#${config.colorScheme.palette.base00}";
    "listFilterWidget.noMatchesOutline" =
      "#${config.colorScheme.palette.base08}";
    "list.filterMatchBackground" = "#${config.colorScheme.palette.base02}";
    "tree.indentGuidesStroke" = "#${config.colorScheme.palette.base05}";

    "activityBar.background" = "#${config.colorScheme.palette.base00}";
    "activityBar.dropBackground" = "#${config.colorScheme.palette.base07}";
    "activityBar.foreground" = "#${config.colorScheme.palette.base05}";
    "activityBar.inactiveForeground" = "#${config.colorScheme.palette.base03}";
    "activityBarBadge.background" = "#${config.colorScheme.palette.base0D}";
    "activityBarBadge.foreground" = "#${config.colorScheme.palette.base07}";
    "activityBar.activeBackground" = "#${config.colorScheme.palette.base02}";

    "sideBar.background" = "#${config.colorScheme.palette.base00}";
    "sideBar.foreground" = "#${config.colorScheme.palette.base05}";
    "sideBar.dropBackground" = "#${config.colorScheme.palette.base00}";
    "sideBarTitle.foreground" = "#${config.colorScheme.palette.base00}";
    "sideBarSectionHeader.background" = "#${config.colorScheme.palette.base00}";
    "sideBarSectionHeader.foreground" = "#${config.colorScheme.palette.base05}";

    "minimap.findMatchHighlight" = "#${config.colorScheme.palette.base0A}";
    "minimap.selectionHighlight" = "#${config.colorScheme.palette.base02}";
    "minimap.errorHighlight" = "#${config.colorScheme.palette.base08}";
    "minimap.warningHighlight" = "#${config.colorScheme.palette.base0A}";
    "minimap.background" = "#${config.colorScheme.palette.base00}";
    "minimap.selectionOccurrenceHighlight" =
      "#${config.colorScheme.palette.base03}";
    "minimapGutter.addedBackground" = "#${config.colorScheme.palette.base0B}";
    "minimapGutter.modifiedBackground" =
      "#${config.colorScheme.palette.base0E}";
    "minimapGutter.deletedBackground" = "#${config.colorScheme.palette.base08}";

    "editorGroup.background" = "#${config.colorScheme.palette.base00}";
    "editorGroup.dropBackground" = "#${config.colorScheme.palette.base02}";
    "editorGroupHeader.noTabsBackground" =
      "#${config.colorScheme.palette.base00}";
    "editorGroupHeader.tabsBackground" =
      "#${config.colorScheme.palette.base00}";
    "editorGroup.emptyBackground" = "#${config.colorScheme.palette.base00}";
    "editorGroup.dropIntoPromptForeground" =
      "#${config.colorScheme.palette.base06}";
    "editorGroup.dropIntoPromptBackground" =
      "#${config.colorScheme.palette.base00}";
    "tab.activeBackground" = "#${config.colorScheme.palette.base00}";
    "tab.unfocusedActiveBackground" = "#${config.colorScheme.palette.base00}";
    "tab.activeForeground" = "#${config.colorScheme.palette.base05}";
    "tab.inactiveBackground" = "#${config.colorScheme.palette.base01}";
    "tab.inactiveForeground" = "#${config.colorScheme.palette.base03}";
    "tab.unfocusedActiveForeground" = "#${config.colorScheme.palette.base04}";
    "tab.unfocusedInactiveForeground" = "#${config.colorScheme.palette.base03}";
    "tab.hoverBackground" = "#${config.colorScheme.palette.base02}";
    "tab.unfocusedHoverBackground" = "#${config.colorScheme.palette.base02}";
    "tab.activeModifiedBorder" = "#${config.colorScheme.palette.base0D}";
    "tab.inactiveModifiedBorder" = "#${config.colorScheme.palette.base0D}";
    "tab.unfocusedActiveModifiedBorder" =
      "#${config.colorScheme.palette.base0D}";
    "tab.unfocusedInactiveModifiedBorder" =
      "#${config.colorScheme.palette.base0D}";
    "editorPane.background" = "#${config.colorScheme.palette.base00}";

    "editor.background" = "#${config.colorScheme.palette.base00}";
    "editor.foreground" = "#${config.colorScheme.palette.base05}";
    "editorLineNumber.foreground" = "#${config.colorScheme.palette.base03}";
    "editorLineNumber.activeForeground" =
      "#${config.colorScheme.palette.base04}";
    "editorCursor.foreground" = "#${config.colorScheme.palette.base05}";
    "editor.selectionBackground" = "#${config.colorScheme.palette.base02}";
    "editor.inactiveSelectionBackground" =
      "#${config.colorScheme.palette.base02}";
    "editor.selectionHighlightBackground" =
      "#${config.colorScheme.palette.base01}";
    "editor.wordHighlightBackground" = "#${config.colorScheme.palette.base02}";
    "editor.wordHighlightStrongBackground" =
      "#${config.colorScheme.palette.base03}";
    "editor.findMatchBackground" = "#${config.colorScheme.palette.base0A}";
    "editor.findMatchHighlightBackground" =
      "#${config.colorScheme.palette.base09}";
    "editor.findRangeHighlightBackground" =
      "#${config.colorScheme.palette.base01}";
    "searchEditor.findMatchBackground" =
      "#${config.colorScheme.palette.base0A}";
    "editor.hoverHighlightBackground" = "#${config.colorScheme.palette.base02}";
    "editor.lineHighlightBackground" = "#${config.colorScheme.palette.base01}";
    "editorLink.activeForeground" = "#${config.colorScheme.palette.base0D}";
    "editor.rangeHighlightBackground" = "#${config.colorScheme.palette.base01}";
    "editorWhitespace.foreground" = "#${config.colorScheme.palette.base03}";
    "editorIndentGuide.background" = "#${config.colorScheme.palette.base03}";
    "editorIndentGuide.activeBackground" =
      "#${config.colorScheme.palette.base04}";
    "editorInlayHint.background" = "#${config.colorScheme.palette.base01}";
    "editorInlayHint.foreground" = "#${config.colorScheme.palette.base05}";
    "editorInlayHint.typeBackground" = "#${config.colorScheme.palette.base01}";
    "editorInlayHint.typeForeground" = "#${config.colorScheme.palette.base05}";
    "editorInlayHint.parameterBackground" =
      "#${config.colorScheme.palette.base01}";
    "editorInlayHint.parameterForeground" =
      "#${config.colorScheme.palette.base05}";
    "editorRuler.foreground" = "#${config.colorScheme.palette.base03}";
    "editorCodeLens.foreground" = "#${config.colorScheme.palette.base02}";
    "editorLightBulb.foreground" = "#${config.colorScheme.palette.base0A}";
    "editorLightBulbAutoFix.foreground" =
      "#${config.colorScheme.palette.base0D}";
    "editorBracketMatch.background" = "#${config.colorScheme.palette.base02}";
    "editorBracketHighlight.foreground1" =
      "#${config.colorScheme.palette.base08}";
    "editorBracketHighlight.foreground2" =
      "#${config.colorScheme.palette.base09}";
    "editorBracketHighlight.foreground3" =
      "#${config.colorScheme.palette.base0A}";
    "editorBracketHighlight.foreground4" =
      "#${config.colorScheme.palette.base0B}";
    "editorBracketHighlight.foreground5" =
      "#${config.colorScheme.palette.base0D}";
    "editorBracketHighlight.foreground6" =
      "#${config.colorScheme.palette.base0E}";
    "editorBracketHighlight.unexpectedBracket.foreground" =
      "#${config.colorScheme.palette.base0F}";
    "editorOverviewRuler.findMatchForeground" =
      "#${config.colorScheme.palette.base0A}";
    "editorOverviewRuler.rangeHighlightForeground" =
      "#${config.colorScheme.palette.base03}";
    "editorOverviewRuler.selectionHighlightForeground" =
      "#${config.colorScheme.palette.base02}";
    "editorOverviewRuler.wordHighlightForeground" =
      "#${config.colorScheme.palette.base07}";
    "editorOverviewRuler.wordHighlightStrongForeground" =
      "#${config.colorScheme.palette.base0D}";
    "editorOverviewRuler.modifiedForeground" =
      "#${config.colorScheme.palette.base0E}";
    "editorOverviewRuler.addedForeground" =
      "#${config.colorScheme.palette.base0B}";
    "editorOverviewRuler.deletedForeground" =
      "#${config.colorScheme.palette.base08}";
    "editorOverviewRuler.errorForeground" =
      "#${config.colorScheme.palette.base08}";
    "editorOverviewRuler.warningForeground" =
      "#${config.colorScheme.palette.base0A}";
    "editorOverviewRuler.infoForeground" =
      "#${config.colorScheme.palette.base0C}";
    "editorOverviewRuler.bracketMatchForeground" =
      "#${config.colorScheme.palette.base06}";
    "editorError.foreground" = "#${config.colorScheme.palette.base08}";
    "editorWarning.foreground" = "#${config.colorScheme.palette.base0A}";
    "editorInfo.foreground" = "#${config.colorScheme.palette.base0C}";
    "editorHint.foreground" = "#${config.colorScheme.palette.base0D}";
    "problemsErrorIcon.foreground" = "#${config.colorScheme.palette.base08}";
    "problemsWarningIcon.foreground" = "#${config.colorScheme.palette.base0A}";
    "problemsInfoIcon.foreground" = "#${config.colorScheme.palette.base0C}";
    "editorGutter.background" = "#${config.colorScheme.palette.base00}";
    "editorGutter.modifiedBackground" = "#${config.colorScheme.palette.base0E}";
    "editorGutter.addedBackground" = "#${config.colorScheme.palette.base0B}";
    "editorGutter.deletedBackground" = "#${config.colorScheme.palette.base08}";
    "editorGutter.commentRangeForeground" =
      "#${config.colorScheme.palette.base04}";
    "editorGutter.foldingControlForeground" =
      "#${config.colorScheme.palette.base05}";

    "diffEditor.insertedTextBackground" =
      "#${config.colorScheme.palette.base0B}";
    "diffEditor.removedTextBackground" =
      "#${config.colorScheme.palette.base08}";
    "diffEditor.diagonalFill" = "#${config.colorScheme.palette.base02}";

    "editorWidget.foreground" = "#${config.colorScheme.palette.base05}";
    "editorWidget.background" = "#${config.colorScheme.palette.base00}";
    "editorSuggestWidget.background" = "#${config.colorScheme.palette.base01}";
    "editorSuggestWidget.foreground" = "#${config.colorScheme.palette.base05}";
    "editorSuggestWidget.focusHighlightForeground" =
      "#${config.colorScheme.palette.base07}";
    "editorSuggestWidget.highlightForeground" =
      "#${config.colorScheme.palette.base0D}";
    "editorSuggestWidget.selectedBackground" =
      "#${config.colorScheme.palette.base02}";
    "editorSuggestWidget.selectedForeground" =
      "#${config.colorScheme.palette.base06}";
    "editorHoverWidget.foreground" = "#${config.colorScheme.palette.base05}";
    "editorHoverWidget.background" = "#${config.colorScheme.palette.base00}";
    "debugExceptionWidget.background" = "#${config.colorScheme.palette.base01}";
    "editorMarkerNavigation.background" =
      "#${config.colorScheme.palette.base01}";
    "editorMarkerNavigationError.background" =
      "#${config.colorScheme.palette.base08}";
    "editorMarkerNavigationWarning.background" =
      "#${config.colorScheme.palette.base0A}";
    "editorMarkerNavigationInfo.background" =
      "#${config.colorScheme.palette.base0D}";
    "editorMarkerNavigationError.headerBackground" =
      "#${config.colorScheme.palette.base08}";
    "editorMarkerNavigationWarning.headerBackground" =
      "#${config.colorScheme.palette.base0A}";
    "editorMarkerNavigationInfo.headerBackground" =
      "#${config.colorScheme.palette.base0C}";

    "peekViewEditor.background" = "#${config.colorScheme.palette.base01}";
    "peekViewEditorGutter.background" = "#${config.colorScheme.palette.base01}";
    "peekViewEditor.matchHighlightBackground" =
      "#${config.colorScheme.palette.base09}";
    "peekViewResult.background" = "#${config.colorScheme.palette.base00}";
    "peekViewResult.fileForeground" = "#${config.colorScheme.palette.base05}";
    "peekViewResult.lineForeground" = "#${config.colorScheme.palette.base03}";
    "peekViewResult.matchHighlightBackground" =
      "#${config.colorScheme.palette.base09}";
    "peekViewResult.selectionBackground" =
      "#${config.colorScheme.palette.base02}";
    "peekViewResult.selectionForeground" =
      "#${config.colorScheme.palette.base05}";
    "peekViewTitle.background" = "#${config.colorScheme.palette.base02}";
    "peekViewTitleDescription.foreground" =
      "#${config.colorScheme.palette.base03}";
    "peekViewTitleLabel.foreground" = "#${config.colorScheme.palette.base05}";

    "merge.currentContentBackground" =
      "#${config.colorScheme.palette.base0D}40";
    "merge.currentHeaderBackground" = "#${config.colorScheme.palette.base0D}40";
    "merge.incomingContentBackground" =
      "#${config.colorScheme.palette.base0B}60";
    "merge.incomingHeaderBackground" =
      "#${config.colorScheme.palette.base0B}60";
    "editorOverviewRuler.currentContentForeground" =
      "#${config.colorScheme.palette.base0D}";
    "editorOverviewRuler.incomingContentForeground" =
      "#${config.colorScheme.palette.base0B}";
    "editorOverviewRuler.commonContentForeground" =
      "#${config.colorScheme.palette.base0F}";

    "panel.background" = "#${config.colorScheme.palette.base00}";
    "panel.dropBackground" = "#${config.colorScheme.palette.base01}";
    "panel.dropBorder" = "#${config.colorScheme.palette.base01}";
    "panelTitle.activeForeground" = "#${config.colorScheme.palette.base05}";
    "panelTitle.inactiveForeground" = "#${config.colorScheme.palette.base03}";

    "statusBar.border" = "#${config.colorScheme.palette.base00}";
    "statusBar.background" = "#${config.colorScheme.palette.base00}";
    "statusBar.foreground" = "#${config.colorScheme.palette.base03}";
    "statusBar.debuggingBackground" = "#${config.colorScheme.palette.base09}";
    "statusBar.debuggingForeground" = "#${config.colorScheme.palette.base07}";
    "statusBar.noFolderBackground" = "#${config.colorScheme.palette.base0E}";
    "statusBar.noFolderForeground" = "#${config.colorScheme.palette.base07}";
    "statusBarItem.activeBackground" = "#${config.colorScheme.palette.base00}";
    "statusBarItem.hoverBackground" = "#${config.colorScheme.palette.base02}";
    "statusBarItem.prominentForeground" =
      "#${config.colorScheme.palette.base07}";
    "statusBarItem.prominentBackground" =
      "#${config.colorScheme.palette.base0E}";
    "statusBarItem.prominentHoverBackground" =
      "#${config.colorScheme.palette.base08}";
    "statusBarItem.remoteBackground" = "#${config.colorScheme.palette.base0B}";
    "statusBarItem.remoteForeground" = "#${config.colorScheme.palette.base07}";
    "statusBarItem.errorBackground" = "#${config.colorScheme.palette.base08}";
    "statusBarItem.errorForeground" = "#${config.colorScheme.palette.base07}";
    "statusBarItem.warningBackground" = "#${config.colorScheme.palette.base0A}";
    "statusBarItem.warningForeground" = "#${config.colorScheme.palette.base07}";

    "titleBar.activeBackground" = "#${config.colorScheme.palette.base00}";
    "titleBar.activeForeground" = "#${config.colorScheme.palette.base05}";
    "titleBar.inactiveBackground" = "#${config.colorScheme.palette.base01}";
    "titleBar.inactiveForeground" = "#${config.colorScheme.palette.base03}";

    "menubar.selectionForeground" = "#${config.colorScheme.palette.base05}";
    "menubar.selectionBackground" = "#${config.colorScheme.palette.base01}";
    "menu.foreground" = "#${config.colorScheme.palette.base05}";
    "menu.background" = "#${config.colorScheme.palette.base01}";
    "menu.selectionForeground" = "#${config.colorScheme.palette.base05}";
    "menu.selectionBackground" = "#${config.colorScheme.palette.base02}";
    "menu.separatorBackground" = "#${config.colorScheme.palette.base07}";

    "commandCenter.foreground" = "#${config.colorScheme.palette.base05}";
    "commandCenter.activeForeground" = "#${config.colorScheme.palette.base07}";
    "commandCenter.background" = "#${config.colorScheme.palette.base00}";
    "commandCenter.activeBackground" = "#${config.colorScheme.palette.base01}";

    "notificationCenterHeader.foreground" =
      "#${config.colorScheme.palette.base05}";
    "notificationCenterHeader.background" =
      "#${config.colorScheme.palette.base01}";
    "notifications.foreground" = "#${config.colorScheme.palette.base05}";
    "notifications.background" = "#${config.colorScheme.palette.base02}";
    "notificationLink.foreground" = "#${config.colorScheme.palette.base0D}";
    "notificationsErrorIcon.foreground" =
      "#${config.colorScheme.palette.base08}";
    "notificationsWarningIcon.foreground" =
      "#${config.colorScheme.palette.base0A}";
    "notificationsInfoIcon.foreground" =
      "#${config.colorScheme.palette.base0D}";

    "notification.background" = "#${config.colorScheme.palette.base02}";
    "notification.foreground" = "#${config.colorScheme.palette.base05}";
    "notification.buttonBackground" = "#${config.colorScheme.palette.base0D}";
    "notification.buttonHoverBackground" =
      "#${config.colorScheme.palette.base02}";
    "notification.buttonForeground" = "#${config.colorScheme.palette.base07}";
    "notification.infoBackground" = "#${config.colorScheme.palette.base0C}";
    "notification.infoForeground" = "#${config.colorScheme.palette.base07}";
    "notification.warningBackground" = "#${config.colorScheme.palette.base0A}";
    "notification.warningForeground" = "#${config.colorScheme.palette.base07}";
    "notification.errorBackground" = "#${config.colorScheme.palette.base08}";
    "notification.errorForeground" = "#${config.colorScheme.palette.base07}";

    "banner.background" = "#${config.colorScheme.palette.base02}";
    "banner.foreground" = "#${config.colorScheme.palette.base05}";
    "banner.iconForeground" = "#${config.colorScheme.palette.base0D}";

    "extensionButton.prominentBackground" =
      "#${config.colorScheme.palette.base0B}";
    "extensionButton.prominentForeground" =
      "#${config.colorScheme.palette.base07}";
    "extensionButton.prominentHoverBackground" =
      "#${config.colorScheme.palette.base02}";
    "extensionBadge.remoteBackground" = "#${config.colorScheme.palette.base09}";
    "extensionBadge.remoteForeground" = "#${config.colorScheme.palette.base07}";
    "extensionIcon.starForeground" = "#${config.colorScheme.palette.base0A}";
    "extensionIcon.verifiedForeground" =
      "#${config.colorScheme.palette.base0D}";
    "extensionIcon.preReleaseForeground" =
      "#${config.colorScheme.palette.base09}";

    "pickerGroup.foreground" = "#${config.colorScheme.palette.base03}";
    "quickInput.background" = "#${config.colorScheme.palette.base01}";
    "quickInput.foreground" = "#${config.colorScheme.palette.base05}";
    "quickInputList.focusBackground" = "#${config.colorScheme.palette.base03}";
    "quickInputList.focusForeground" = "#${config.colorScheme.palette.base07}";
    "quickInputList.focusIconForeground" =
      "#${config.colorScheme.palette.base07}";

    "keybindingLabel.background" = "#${config.colorScheme.palette.base02}";
    "keybindingLabel.foreground" = "#${config.colorScheme.palette.base05}";

    "keybindingTable.headerBackground" =
      "#${config.colorScheme.palette.base02}";
    "keybindingTable.rowsBackground" = "#${config.colorScheme.palette.base01}";

    "terminal.background" = "#${config.colorScheme.palette.base00}";
    "terminal.foreground" = "#${config.colorScheme.palette.base05}";
    "terminal.ansiBlack" = "#${config.colorScheme.palette.base00}";
    "terminal.ansiRed" = "#${config.colorScheme.palette.base08}";
    "terminal.ansiGreen" = "#${config.colorScheme.palette.base0B}";
    "terminal.ansiYellow" = "#${config.colorScheme.palette.base0A}";
    "terminal.ansiBlue" = "#${config.colorScheme.palette.base0D}";
    "terminal.ansiMagenta" = "#${config.colorScheme.palette.base0E}";
    "terminal.ansiCyan" = "#${config.colorScheme.palette.base0C}";
    "terminal.ansiWhite" = "#${config.colorScheme.palette.base05}";
    "terminal.ansiBrightBlack" = "#${config.colorScheme.palette.base03}";
    "terminal.ansiBrightRed" = "#${config.colorScheme.palette.base08}";
    "terminal.ansiBrightGreen" = "#${config.colorScheme.palette.base0B}";
    "terminal.ansiBrightYellow" = "#${config.colorScheme.palette.base0A}";
    "terminal.ansiBrightBlue" = "#${config.colorScheme.palette.base0D}";
    "terminal.ansiBrightMagenta" = "#${config.colorScheme.palette.base0E}";
    "terminal.ansiBrightCyan" = "#${config.colorScheme.palette.base0C}";
    "terminal.ansiBrightWhite" = "#${config.colorScheme.palette.base07}";
    "terminalCursor.foreground" = "#${config.colorScheme.palette.base05}";
    "terminalOverviewRuler.cursorForeground" = "#ff0000";
    "terminalOverviewRuler.findMatchForeground" = "#ff0000";

    "debugToolBar.background" = "#${config.colorScheme.palette.base01}";
    "debugView.stateLabelForeground" = "#${config.colorScheme.palette.base07}";
    "debugView.stateLabelBackground" = "#${config.colorScheme.palette.base0D}";
    "debugView.valueChangedHighlight" = "#${config.colorScheme.palette.base0D}";
    "debugTokenExpression.name" = "#${config.colorScheme.palette.base0E}";
    "debugTokenExpression.value" = "#${config.colorScheme.palette.base05}";
    "debugTokenExpression.string" = "#${config.colorScheme.palette.base0B}";
    "debugTokenExpression.boolean" = "#${config.colorScheme.palette.base09}";
    "debugTokenExpression.number" = "#${config.colorScheme.palette.base09}";
    "debugTokenExpression.error" = "#${config.colorScheme.palette.base08}";

    "testing.iconFailed" = "#${config.colorScheme.palette.base08}";
    "testing.iconErrored" = "#${config.colorScheme.palette.base0F}";
    "testing.iconPassed" = "#${config.colorScheme.palette.base0B}";
    "testing.runAction" = "#${config.colorScheme.palette.base04}";
    "testing.iconQueued" = "#${config.colorScheme.palette.base0A}";
    "testing.iconUnset" = "#${config.colorScheme.palette.base04}";
    "testing.iconSkipped" = "#${config.colorScheme.palette.base0E}";
    "testing.peekHeaderBackground" = "#${config.colorScheme.palette.base01}";
    "testing.message.error.decorationForeground" =
      "#${config.colorScheme.palette.base05}";
    "testing.message.error.lineBackground" =
      "#${config.colorScheme.palette.base08}";
    "testing.message.info.decorationForeground" =
      "#${config.colorScheme.palette.base05}";
    "testing.message.info.lineBackground" =
      "#${config.colorScheme.palette.base0D}";

    "welcomePage.background" = "#${config.colorScheme.palette.base00}";
    "welcomePage.buttonBackground" = "#${config.colorScheme.palette.base01}";
    "welcomePage.buttonHoverBackground" =
      "#${config.colorScheme.palette.base02}";
    "welcomePage.progress.background" = "#${config.colorScheme.palette.base03}";
    "welcomePage.progress.foreground" = "#${config.colorScheme.palette.base0D}";
    "welcomePage.tileBackground" = "#${config.colorScheme.palette.base01}";
    "welcomePage.tileHoverBackground" = "#${config.colorScheme.palette.base02}";
    "walkThrough.embeddedEditorBackground" =
      "#${config.colorScheme.palette.base00}";

    "gitDecoration.addedResourceForeground" =
      "#${config.colorScheme.palette.base0B}";
    "gitDecoration.modifiedResourceForeground" =
      "#${config.colorScheme.palette.base0E}";
    "gitDecoration.deletedResourceForeground" =
      "#${config.colorScheme.palette.base08}";
    "gitDecoration.renamedResourceForeground" =
      "#${config.colorScheme.palette.base0C}";
    "gitDecoration.stageModifiedResourceForeground" =
      "#${config.colorScheme.palette.base0E}";
    "gitDecoration.stageDeletedResourceForeground" =
      "#${config.colorScheme.palette.base08}";
    "gitDecoration.untrackedResourceForeground" =
      "#${config.colorScheme.palette.base09}";
    "gitDecoration.ignoredResourceForeground" =
      "#${config.colorScheme.palette.base03}";
    "gitDecoration.conflictingResourceForeground" =
      "#${config.colorScheme.palette.base0A}";
    "gitDecoration.submoduleResourceForeground" =
      "#${config.colorScheme.palette.base0F}";

    "settings.headerForeground" = "#${config.colorScheme.palette.base05}";
    "settings.modifiedItemIndicator" = "#${config.colorScheme.palette.base0D}";
    "settings.modifiedItemForeground" = "#${config.colorScheme.palette.base0B}";
    "settings.dropdownBackground" = "#${config.colorScheme.palette.base01}";
    "settings.dropdownForeground" = "#${config.colorScheme.palette.base05}";
    "settings.checkboxBackground" = "#${config.colorScheme.palette.base01}";
    "settings.checkboxForeground" = "#${config.colorScheme.palette.base05}";
    "settings.rowHoverBackground" = "#${config.colorScheme.palette.base02}";
    "settings.textInputBackground" = "#${config.colorScheme.palette.base01}";
    "settings.textInputForeground" = "#${config.colorScheme.palette.base05}";
    "settings.numberInputBackground" = "#${config.colorScheme.palette.base01}";
    "settings.numberInputForeground" = "#${config.colorScheme.palette.base05}";
    "settings.focusedRowBackground" = "#${config.colorScheme.palette.base02}";
    "settings.headerBorder" = "#${config.colorScheme.palette.base05}";
    "settings.sashBorder" = "#${config.colorScheme.palette.base05}";

    "breadcrumb.foreground" = "#${config.colorScheme.palette.base05}";
    "breadcrumb.background" = "#${config.colorScheme.palette.base01}";
    "breadcrumb.focusForeground" = "#${config.colorScheme.palette.base06}";
    "breadcrumb.activeSelectionForeground" =
      "#${config.colorScheme.palette.base07}";
    "breadcrumbPicker.background" = "#${config.colorScheme.palette.base01}";

    "editor.snippetTabstopHighlightBackground" =
      "#${config.colorScheme.palette.base02}";
    "editor.snippetFinalTabstopHighlightBackground" =
      "#${config.colorScheme.palette.base03}";

    "symbolIcon.arrayForeground" = "#${config.colorScheme.palette.base05}";
    "symbolIcon.booleanForeground" = "#${config.colorScheme.palette.base09}";
    "symbolIcon.classForeground" = "#${config.colorScheme.palette.base0A}";
    "symbolIcon.colorForeground" = "#f0f";
    "symbolIcon.constantForeground" = "#${config.colorScheme.palette.base09}";
    "symbolIcon.constructorForeground" =
      "#${config.colorScheme.palette.base0D}";
    "symbolIcon.enumeratorForeground" = "#${config.colorScheme.palette.base09}";
    "symbolIcon.enumeratorMemberForeground" =
      "#${config.colorScheme.palette.base0D}";
    "symbolIcon.eventForeground" = "#${config.colorScheme.palette.base0A}";
    "symbolIcon.fieldForeground" = "#${config.colorScheme.palette.base08}";
    "symbolIcon.fileForeground" = "#${config.colorScheme.palette.base05}";
    "symbolIcon.folderForeground" = "#${config.colorScheme.palette.base05}";
    "symbolIcon.functionForeground" = "#${config.colorScheme.palette.base0D}";
    "symbolIcon.interfaceForeground" = "#${config.colorScheme.palette.base0D}";
    "symbolIcon.keyForeground" = "#f0f";
    "symbolIcon.keywordForeground" = "#${config.colorScheme.palette.base0E}";
    "symbolIcon.methodForeground" = "#${config.colorScheme.palette.base0D}";
    "symbolIcon.moduleForeground" = "#${config.colorScheme.palette.base05}";
    "symbolIcon.namespaceForeground" = "#${config.colorScheme.palette.base05}";
    "symbolIcon.nullForeground" = "#${config.colorScheme.palette.base0F}";
    "symbolIcon.numberForeground" = "#${config.colorScheme.palette.base09}";
    "symbolIcon.objectForeground" = "#f0f";
    "symbolIcon.operatorForeground" = "#f0f";
    "symbolIcon.packageForeground" = "#f0f";
    "symbolIcon.propertyForeground" = "#${config.colorScheme.palette.base05}";
    "symbolIcon.referenceForeground" = "#f0f";
    "symbolIcon.snippetForeground" = "#${config.colorScheme.palette.base05}";
    "symbolIcon.stringForeground" = "#${config.colorScheme.palette.base0B}";
    "symbolIcon.structForeground" = "#${config.colorScheme.palette.base0A}";
    "symbolIcon.textForeground" = "#${config.colorScheme.palette.base05}";
    "symbolIcon.typeParameterForeground" = "#f0f";
    "symbolIcon.unitForeground" = "#f0f";
    "symbolIcon.variableForeground" = "#${config.colorScheme.palette.base08}";

    "debugIcon.breakpointForeground" = "#${config.colorScheme.palette.base08}";
    "debugIcon.breakpointDisabledForeground" =
      "#${config.colorScheme.palette.base04}";
    "debugIcon.breakpointUnverifiedForeground" =
      "#${config.colorScheme.palette.base02}";
    "debugIcon.breakpointCurrentStackframeForeground" =
      "#${config.colorScheme.palette.base0A}";
    "debugIcon.breakpointStackframeForeground" =
      "#${config.colorScheme.palette.base0F}";
    "debugIcon.startForeground" = "#${config.colorScheme.palette.base0B}";
    "debugIcon.pauseForeground" = "#${config.colorScheme.palette.base0D}";
    "debugIcon.stopForeground" = "#${config.colorScheme.palette.base08}";
    "debugIcon.disconnectForeground" = "#${config.colorScheme.palette.base08}";
    "debugIcon.restartForeground" = "#${config.colorScheme.palette.base0B}";
    "debugIcon.stepOverForeground" = "#${config.colorScheme.palette.base0D}";
    "debugIcon.stepIntoForeground" = "#${config.colorScheme.palette.base0C}";
    "debugIcon.stepOutForeground" = "#${config.colorScheme.palette.base0E}";
    "debugIcon.continueForeground" = "#${config.colorScheme.palette.base0B}";
    "debugIcon.stepBackForeground" = "#${config.colorScheme.palette.base0F}";
    "debugConsole.infoForeground" = "#${config.colorScheme.palette.base05}";
    "debugConsole.warningForeground" = "#${config.colorScheme.palette.base0A}";
    "debugConsole.errorForeground" = "#${config.colorScheme.palette.base08}";
    "debugConsole.sourceForeground" = "#${config.colorScheme.palette.base05}";
    "debugConsoleInputIcon.foreground" =
      "#${config.colorScheme.palette.base05}";

    "notebook.editorBackground" = "#${config.colorScheme.palette.base00}";
    "notebook.cellBorderColor" = "#${config.colorScheme.palette.base03}";
    "notebook.cellHoverBackground" = "#${config.colorScheme.palette.base01}";
    "notebook.cellToolbarSeparator" = "#${config.colorScheme.palette.base02}";
    "notebook.cellEditorBackground" = "#${config.colorScheme.palette.base00}";
    "notebook.focusedCellBackground" = "#${config.colorScheme.palette.base02}";
    "notebook.focusedCellBorder" = "#${config.colorScheme.palette.base0D}";
    "notebook.focusedEditorBorder" = "#${config.colorScheme.palette.base0D}";
    "notebook.inactiveFocusedCellBorder" =
      "#${config.colorScheme.palette.base03}";
    "notebook.selectedCellBackground" = "#${config.colorScheme.palette.base02}";
    "notebookStatusErrorIcon.foreground" =
      "#${config.colorScheme.palette.base08}";
    "notebookStatusRunningIcon.foreground" =
      "#${config.colorScheme.palette.base0C}";
    "notebookStatusSuccessIcon.foreground" =
      "#${config.colorScheme.palette.base0B}";

    "charts.foreground" = "#${config.colorScheme.palette.base05}";
    "charts.lines" = "#${config.colorScheme.palette.base05}";
    "charts.red" = "#${config.colorScheme.palette.base08}";
    "charts.blue" = "#${config.colorScheme.palette.base0D}";
    "charts.yellow" = "#${config.colorScheme.palette.base0A}";
    "charts.orange" = "#${config.colorScheme.palette.base09}";
    "charts.green" = "#${config.colorScheme.palette.base0B}";
    "charts.purple" = "#${config.colorScheme.palette.base0E}";

    "ports.iconRunningProcessForeground" =
      "#${config.colorScheme.palette.base09}";
  };
  "workbench.activityBar.location" = "hidden";

  # new config
  "workbench.tree.renderIndentGuides" = "none";
  "workbench.statusBar.visible" = true;
  "workbench.editor.showTabs" = false;
  "workbench.layoutControl.enabled" = false;
  "workbench.startupEditor" = "none";
  "workbench.tips.enabled" = false;
  "editor.guides.indentation" = false;
  "editor.matchBrackets" = "never";
  "editor.lightbulb.enabled" = false;
  "editor.hover.enabled" = true;
  "editor.action.showDefinitionPreviewHover" = true;
  "editor.showFoldingControls" = "never";
  "editor.scrollbar.horizontal" = "hidden";
  "editor.scrollbar.vertical" = "hidden";
  "editor.overviewRulerBorder" = false;
  "editor.cursorBlinking" = "solid";
  "editor.cursorSmoothCaretAnimation" = "on";
  "editor.detectIndentation" = false;
  "editor.fontLigatures" = true;
  "breadcrumbs.enabled" = false;
  "explorer.confirmDragAndDrop" = false;
  "explorer.confirmDelete" = false;
  "explorer.compactFolders" = false;
  "git.decorations.enabled" = true;
  "files.insertFinalNewline" = true;
  "extensions.ignoreRecommendations" = false;
  "terminal.integrated.tabs.enabled" = false;
  "terminal.integrated.lineHeight" = 1.5;
  "terminal.integrated.fontSize" = 14;
  "terminal.integrated.env.osx" = { FIG_NEW_SESSION = "1"; };
  "window.titleBarStyle" = "native";
  "apc.electron" = {
    titleBarStyle = "hidden";
    trafficLightPosition = {
      x = 70;
      y = 70000;
    };
  };
  "window.menuBarVisibility" = "toggle";
  "window.commandCenter" = false;
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
  "vim.easymotion" = true;
  "vim.incsearch" = true;
  "vim.useSystemClipboard" = false;
  "vim.useCtrlKeys" = true;
  "vim.hlsearch" = true;
  "vim.insertModeKeyBindings" = [{
    before = [ "h" "h" ];
    after = [ "<Esc>" ];
  }];
}
