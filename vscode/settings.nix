{ config }: {
  # editor settings
  "editor.formatOnSave" = true;
  "editor.minimap.enabled" = false;
  "editor.fontSize" = 14;
  "editor.lineHeight" = 24;
  "editor.codeActionsOnSave" = {
    "source.fixAll.eslint" = true;
    "source.fixAll.stylelint" = true;
  };
  "editor.fontLigatures" = false;
  "editor.cursorStyle" = "block";
  "editor.tabSize" = 2;
  "editor.lineNumbers" = "relative";

  # theme
  "workbench.activityBar.visible" = false;
  "workbench.colorTheme" = "Palenight Theme";

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
    "foreground" = "#${config.colorScheme.colors.base05}";
    "disabledForeground" = "#${config.colorScheme.colors.base04}";
    "widget.shadow" = "#${config.colorScheme.colors.base00}";
    "selection.background" = "#${config.colorScheme.colors.base0D}";
    "descriptionForeground" = "#${config.colorScheme.colors.base03}";
    "errorForeground" = "#${config.colorScheme.colors.base08}";
    "icon.foreground" = "#${config.colorScheme.colors.base04}";

    "textBlockQuote.background" = "#${config.colorScheme.colors.base01}";
    "textBlockQuote.border" = "#${config.colorScheme.colors.base0D}";
    "textCodeBlock.background" = "#${config.colorScheme.colors.base00}";
    "textLink.activeForeground" = "#${config.colorScheme.colors.base0C}";
    "textLink.foreground" = "#${config.colorScheme.colors.base0D}";
    "textPreformat.foreground" = "#${config.colorScheme.colors.base0D}";
    "textSeparator.foreground" = "#f0f";

    "toolbar.hoverBackground" = "#${config.colorScheme.colors.base02}";
    "toolbar.activeBackground" = "#${config.colorScheme.colors.base03}";

    "button.background" = "#${config.colorScheme.colors.base0D}";
    "button.foreground" = "#${config.colorScheme.colors.base07}";
    "button.hoverBackground" = "#${config.colorScheme.colors.base04}";
    "button.secondaryForeground" = "#${config.colorScheme.colors.base07}";
    "button.secondaryBackground" = "#${config.colorScheme.colors.base0E}";
    "button.secondaryHoverBackground" = "#${config.colorScheme.colors.base04}";
    "checkbox.background" = "#${config.colorScheme.colors.base00}";
    "checkbox.foreground" = "#${config.colorScheme.colors.base05}";

    "dropdown.background" = "#${config.colorScheme.colors.base00}";
    "dropdown.listBackground" = "#${config.colorScheme.colors.base00}";
    "dropdown.foreground" = "#${config.colorScheme.colors.base05}";

    "input.background" = "#${config.colorScheme.colors.base00}";
    "input.foreground" = "#${config.colorScheme.colors.base05}";
    "input.placeholderForeground" = "#${config.colorScheme.colors.base03}";
    "inputOption.activeBackground" = "#${config.colorScheme.colors.base02}";
    "inputOption.activeBorder" = "#${config.colorScheme.colors.base09}";
    "inputOption.activeForeground" = "#${config.colorScheme.colors.base05}";
    "inputValidation.errorBackground" = "#${config.colorScheme.colors.base08}";
    "inputValidation.errorForeground" = "#${config.colorScheme.colors.base05}";
    "inputValidation.errorBorder" = "#${config.colorScheme.colors.base08}";
    "inputValidation.infoBackground" = "#${config.colorScheme.colors.base0D}";
    "inputValidation.infoForeground" = "#${config.colorScheme.colors.base05}";
    "inputValidation.infoBorder" = "#${config.colorScheme.colors.base0D}";
    "inputValidation.warningBackground" =
      "#${config.colorScheme.colors.base0A}";
    "inputValidation.warningForeground" =
      "#${config.colorScheme.colors.base05}";
    "inputValidation.warningBorder" = "#${config.colorScheme.colors.base0A}";

    "scrollbar.shadow" = "#${config.colorScheme.colors.base01}";
    "scrollbarSlider.activeBackground" =
      "#${config.colorScheme.colors.base04}6f";
    "scrollbarSlider.background" = "#${config.colorScheme.colors.base02}6f";
    "scrollbarSlider.hoverBackground" =
      "#${config.colorScheme.colors.base03}6f";

    "badge.background" = "#${config.colorScheme.colors.base00}";
    "badge.foreground" = "#${config.colorScheme.colors.base05}";

    "progressBar.background" = "#${config.colorScheme.colors.base03}";

    "list.activeSelectionBackground" = "#${config.colorScheme.colors.base02}";
    "list.activeSelectionForeground" = "#${config.colorScheme.colors.base05}";
    "list.dropBackground" = "#${config.colorScheme.colors.base07}";
    "list.focusBackground" = "#${config.colorScheme.colors.base02}";
    "list.focusForeground" = "#${config.colorScheme.colors.base05}";
    "list.highlightForeground" = "#${config.colorScheme.colors.base07}";
    "list.hoverBackground" = "#${config.colorScheme.colors.base03}";
    "list.hoverForeground" = "#${config.colorScheme.colors.base05}";
    "list.inactiveSelectionBackground" = "#${config.colorScheme.colors.base02}";
    "list.inactiveSelectionForeground" = "#${config.colorScheme.colors.base05}";
    "list.inactiveFocusBackground" = "#${config.colorScheme.colors.base02}";
    "list.invalidItemForeground" = "#${config.colorScheme.colors.base08}";
    "list.errorForeground" = "#${config.colorScheme.colors.base08}";
    "list.warningForeground" = "#${config.colorScheme.colors.base0A}";
    "listFilterWidget.background" = "#${config.colorScheme.colors.base00}";
    "listFilterWidget.noMatchesOutline" =
      "#${config.colorScheme.colors.base08}";
    "list.filterMatchBackground" = "#${config.colorScheme.colors.base02}";
    "tree.indentGuidesStroke" = "#${config.colorScheme.colors.base05}";

    "activityBar.background" = "#${config.colorScheme.colors.base00}";
    "activityBar.dropBackground" = "#${config.colorScheme.colors.base07}";
    "activityBar.foreground" = "#${config.colorScheme.colors.base05}";
    "activityBar.inactiveForeground" = "#${config.colorScheme.colors.base03}";
    "activityBarBadge.background" = "#${config.colorScheme.colors.base0D}";
    "activityBarBadge.foreground" = "#${config.colorScheme.colors.base07}";
    "activityBar.activeBackground" = "#${config.colorScheme.colors.base02}";

    "sideBar.background" = "#${config.colorScheme.colors.base01}";
    "sideBar.foreground" = "#${config.colorScheme.colors.base05}";
    "sideBar.dropBackground" = "#${config.colorScheme.colors.base02}6f";
    "sideBarTitle.foreground" = "#${config.colorScheme.colors.base05}";
    "sideBarSectionHeader.background" = "#${config.colorScheme.colors.base03}";
    "sideBarSectionHeader.foreground" = "#${config.colorScheme.colors.base05}";

    "minimap.findMatchHighlight" = "#${config.colorScheme.colors.base0A}6f";
    "minimap.selectionHighlight" = "#${config.colorScheme.colors.base02}6f";
    "minimap.errorHighlight" = "#${config.colorScheme.colors.base08}";
    "minimap.warningHighlight" = "#${config.colorScheme.colors.base0A}";
    "minimap.background" = "#${config.colorScheme.colors.base00}";
    "minimap.selectionOccurrenceHighlight" =
      "#${config.colorScheme.colors.base03}";
    "minimapGutter.addedBackground" = "#${config.colorScheme.colors.base0B}";
    "minimapGutter.modifiedBackground" = "#${config.colorScheme.colors.base0E}";
    "minimapGutter.deletedBackground" = "#${config.colorScheme.colors.base08}";

    "editorGroup.background" = "#${config.colorScheme.colors.base00}";
    "editorGroup.dropBackground" = "#${config.colorScheme.colors.base02}6f";
    "editorGroupHeader.noTabsBackground" =
      "#${config.colorScheme.colors.base01}";
    "editorGroupHeader.tabsBackground" = "#${config.colorScheme.colors.base01}";
    "editorGroup.emptyBackground" = "#${config.colorScheme.colors.base00}";
    "editorGroup.dropIntoPromptForeground" =
      "#${config.colorScheme.colors.base06}";
    "editorGroup.dropIntoPromptBackground" =
      "#${config.colorScheme.colors.base00}";
    "tab.activeBackground" = "#${config.colorScheme.colors.base00}";
    "tab.unfocusedActiveBackground" = "#${config.colorScheme.colors.base00}";
    "tab.activeForeground" = "#${config.colorScheme.colors.base05}";
    "tab.inactiveBackground" = "#${config.colorScheme.colors.base01}";
    "tab.inactiveForeground" = "#${config.colorScheme.colors.base03}";
    "tab.unfocusedActiveForeground" = "#${config.colorScheme.colors.base04}";
    "tab.unfocusedInactiveForeground" = "#${config.colorScheme.colors.base03}";
    "tab.hoverBackground" = "#${config.colorScheme.colors.base02}";
    "tab.unfocusedHoverBackground" = "#${config.colorScheme.colors.base02}";
    "tab.activeModifiedBorder" = "#${config.colorScheme.colors.base0D}";
    "tab.inactiveModifiedBorder" = "#${config.colorScheme.colors.base0D}";
    "tab.unfocusedActiveModifiedBorder" =
      "#${config.colorScheme.colors.base0D}";
    "tab.unfocusedInactiveModifiedBorder" =
      "#${config.colorScheme.colors.base0D}";
    "editorPane.background" = "#${config.colorScheme.colors.base00}";

    "editor.background" = "#${config.colorScheme.colors.base00}";
    "editor.foreground" = "#${config.colorScheme.colors.base05}";
    "editorLineNumber.foreground" = "#${config.colorScheme.colors.base03}";
    "editorLineNumber.activeForeground" =
      "#${config.colorScheme.colors.base04}";
    "editorCursor.foreground" = "#${config.colorScheme.colors.base05}";
    "editor.selectionBackground" = "#${config.colorScheme.colors.base02}";
    "editor.inactiveSelectionBackground" =
      "#${config.colorScheme.colors.base02}";
    "editor.selectionHighlightBackground" =
      "#${config.colorScheme.colors.base01}";
    "editor.wordHighlightBackground" = "#${config.colorScheme.colors.base02}6f";
    "editor.wordHighlightStrongBackground" =
      "#${config.colorScheme.colors.base03}6f";
    "editor.findMatchBackground" = "#${config.colorScheme.colors.base0A}6f";
    "editor.findMatchHighlightBackground" =
      "#${config.colorScheme.colors.base09}6f";
    "editor.findRangeHighlightBackground" =
      "#${config.colorScheme.colors.base01}6f";
    "searchEditor.findMatchBackground" =
      "#${config.colorScheme.colors.base0A}6f";
    "editor.hoverHighlightBackground" =
      "#${config.colorScheme.colors.base02}6f";
    "editor.lineHighlightBackground" = "#${config.colorScheme.colors.base01}";
    "editorLink.activeForeground" = "#${config.colorScheme.colors.base0D}";
    "editor.rangeHighlightBackground" =
      "#${config.colorScheme.colors.base01}6f";
    "editorWhitespace.foreground" = "#${config.colorScheme.colors.base03}";
    "editorIndentGuide.background" = "#${config.colorScheme.colors.base03}";
    "editorIndentGuide.activeBackground" =
      "#${config.colorScheme.colors.base04}";
    "editorInlayHint.background" = "#${config.colorScheme.colors.base01}";
    "editorInlayHint.foreground" = "#${config.colorScheme.colors.base05}";
    "editorInlayHint.typeBackground" = "#${config.colorScheme.colors.base01}";
    "editorInlayHint.typeForeground" = "#${config.colorScheme.colors.base05}";
    "editorInlayHint.parameterBackground" =
      "#${config.colorScheme.colors.base01}";
    "editorInlayHint.parameterForeground" =
      "#${config.colorScheme.colors.base05}";
    "editorRuler.foreground" = "#${config.colorScheme.colors.base03}";
    "editorCodeLens.foreground" = "#${config.colorScheme.colors.base02}";
    "editorLightBulb.foreground" = "#${config.colorScheme.colors.base0A}";
    "editorLightBulbAutoFix.foreground" =
      "#${config.colorScheme.colors.base0D}";
    "editorBracketMatch.background" = "#${config.colorScheme.colors.base02}";
    "editorBracketHighlight.foreground1" =
      "#${config.colorScheme.colors.base08}";
    "editorBracketHighlight.foreground2" =
      "#${config.colorScheme.colors.base09}";
    "editorBracketHighlight.foreground3" =
      "#${config.colorScheme.colors.base0A}";
    "editorBracketHighlight.foreground4" =
      "#${config.colorScheme.colors.base0B}";
    "editorBracketHighlight.foreground5" =
      "#${config.colorScheme.colors.base0D}";
    "editorBracketHighlight.foreground6" =
      "#${config.colorScheme.colors.base0E}";
    "editorBracketHighlight.unexpectedBracket.foreground" =
      "#${config.colorScheme.colors.base0F}";
    "editorOverviewRuler.findMatchForeground" =
      "#${config.colorScheme.colors.base0A}6f";
    "editorOverviewRuler.rangeHighlightForeground" =
      "#${config.colorScheme.colors.base03}6f";
    "editorOverviewRuler.selectionHighlightForeground" =
      "#${config.colorScheme.colors.base02}6f";
    "editorOverviewRuler.wordHighlightForeground" =
      "#${config.colorScheme.colors.base07}6f";
    "editorOverviewRuler.wordHighlightStrongForeground" =
      "#${config.colorScheme.colors.base0D}6f";
    "editorOverviewRuler.modifiedForeground" =
      "#${config.colorScheme.colors.base0E}";
    "editorOverviewRuler.addedForeground" =
      "#${config.colorScheme.colors.base0B}";
    "editorOverviewRuler.deletedForeground" =
      "#${config.colorScheme.colors.base08}";
    "editorOverviewRuler.errorForeground" =
      "#${config.colorScheme.colors.base08}";
    "editorOverviewRuler.warningForeground" =
      "#${config.colorScheme.colors.base0A}";
    "editorOverviewRuler.infoForeground" =
      "#${config.colorScheme.colors.base0C}";
    "editorOverviewRuler.bracketMatchForeground" =
      "#${config.colorScheme.colors.base06}";
    "editorError.foreground" = "#${config.colorScheme.colors.base08}";
    "editorWarning.foreground" = "#${config.colorScheme.colors.base0A}";
    "editorInfo.foreground" = "#${config.colorScheme.colors.base0C}";
    "editorHint.foreground" = "#${config.colorScheme.colors.base0D}";
    "problemsErrorIcon.foreground" = "#${config.colorScheme.colors.base08}";
    "problemsWarningIcon.foreground" = "#${config.colorScheme.colors.base0A}";
    "problemsInfoIcon.foreground" = "#${config.colorScheme.colors.base0C}";
    "editorGutter.background" = "#${config.colorScheme.colors.base00}";
    "editorGutter.modifiedBackground" = "#${config.colorScheme.colors.base0E}";
    "editorGutter.addedBackground" = "#${config.colorScheme.colors.base0B}";
    "editorGutter.deletedBackground" = "#${config.colorScheme.colors.base08}";
    "editorGutter.commentRangeForeground" =
      "#${config.colorScheme.colors.base04}";
    "editorGutter.foldingControlForeground" =
      "#${config.colorScheme.colors.base05}";

    "diffEditor.insertedTextBackground" =
      "#${config.colorScheme.colors.base0B}20";
    "diffEditor.removedTextBackground" =
      "#${config.colorScheme.colors.base08}20";
    "diffEditor.diagonalFill" = "#${config.colorScheme.colors.base02}";

    "editorWidget.foreground" = "#${config.colorScheme.colors.base05}";
    "editorWidget.background" = "#${config.colorScheme.colors.base00}";
    "editorSuggestWidget.background" = "#${config.colorScheme.colors.base01}";
    "editorSuggestWidget.foreground" = "#${config.colorScheme.colors.base05}";
    "editorSuggestWidget.focusHighlightForeground" =
      "#${config.colorScheme.colors.base07}";
    "editorSuggestWidget.highlightForeground" =
      "#${config.colorScheme.colors.base0D}";
    "editorSuggestWidget.selectedBackground" =
      "#${config.colorScheme.colors.base02}";
    "editorSuggestWidget.selectedForeground" =
      "#${config.colorScheme.colors.base06}";
    "editorHoverWidget.foreground" = "#${config.colorScheme.colors.base05}";
    "editorHoverWidget.background" = "#${config.colorScheme.colors.base00}";
    "debugExceptionWidget.background" = "#${config.colorScheme.colors.base01}";
    "editorMarkerNavigation.background" =
      "#${config.colorScheme.colors.base01}";
    "editorMarkerNavigationError.background" =
      "#${config.colorScheme.colors.base08}";
    "editorMarkerNavigationWarning.background" =
      "#${config.colorScheme.colors.base0A}";
    "editorMarkerNavigationInfo.background" =
      "#${config.colorScheme.colors.base0D}";
    "editorMarkerNavigationError.headerBackground" =
      "#${config.colorScheme.colors.base08}20";
    "editorMarkerNavigationWarning.headerBackground" =
      "#${config.colorScheme.colors.base0A}20";
    "editorMarkerNavigationInfo.headerBackground" =
      "#${config.colorScheme.colors.base0C}20";

    "peekViewEditor.background" = "#${config.colorScheme.colors.base01}";
    "peekViewEditorGutter.background" = "#${config.colorScheme.colors.base01}";
    "peekViewEditor.matchHighlightBackground" =
      "#${config.colorScheme.colors.base09}6f";
    "peekViewResult.background" = "#${config.colorScheme.colors.base00}";
    "peekViewResult.fileForeground" = "#${config.colorScheme.colors.base05}";
    "peekViewResult.lineForeground" = "#${config.colorScheme.colors.base03}";
    "peekViewResult.matchHighlightBackground" =
      "#${config.colorScheme.colors.base09}6f";
    "peekViewResult.selectionBackground" =
      "#${config.colorScheme.colors.base02}";
    "peekViewResult.selectionForeground" =
      "#${config.colorScheme.colors.base05}";
    "peekViewTitle.background" = "#${config.colorScheme.colors.base02}";
    "peekViewTitleDescription.foreground" =
      "#${config.colorScheme.colors.base03}";
    "peekViewTitleLabel.foreground" = "#${config.colorScheme.colors.base05}";

    "merge.currentContentBackground" = "#${config.colorScheme.colors.base0D}40";
    "merge.currentHeaderBackground" = "#${config.colorScheme.colors.base0D}40";
    "merge.incomingContentBackground" =
      "#${config.colorScheme.colors.base0B}60";
    "merge.incomingHeaderBackground" = "#${config.colorScheme.colors.base0B}60";
    "editorOverviewRuler.currentContentForeground" =
      "#${config.colorScheme.colors.base0D}";
    "editorOverviewRuler.incomingContentForeground" =
      "#${config.colorScheme.colors.base0B}";
    "editorOverviewRuler.commonContentForeground" =
      "#${config.colorScheme.colors.base0F}";

    "panel.background" = "#${config.colorScheme.colors.base00}";
    "panel.dropBackground" = "#${config.colorScheme.colors.base01}6f";
    "panel.dropBorder" = "#${config.colorScheme.colors.base01}6f";
    "panelTitle.activeForeground" = "#${config.colorScheme.colors.base05}";
    "panelTitle.inactiveForeground" = "#${config.colorScheme.colors.base03}";

    "statusBar.background" = "#${config.colorScheme.colors.base0D}";
    "statusBar.foreground" = "#${config.colorScheme.colors.base07}";
    "statusBar.debuggingBackground" = "#${config.colorScheme.colors.base09}";
    "statusBar.debuggingForeground" = "#${config.colorScheme.colors.base07}";
    "statusBar.noFolderBackground" = "#${config.colorScheme.colors.base0E}";
    "statusBar.noFolderForeground" = "#${config.colorScheme.colors.base07}";
    "statusBarItem.activeBackground" = "#${config.colorScheme.colors.base03}";
    "statusBarItem.hoverBackground" = "#${config.colorScheme.colors.base02}";
    "statusBarItem.prominentForeground" =
      "#${config.colorScheme.colors.base07}";
    "statusBarItem.prominentBackground" =
      "#${config.colorScheme.colors.base0E}";
    "statusBarItem.prominentHoverBackground" =
      "#${config.colorScheme.colors.base08}";
    "statusBarItem.remoteBackground" = "#${config.colorScheme.colors.base0B}";
    "statusBarItem.remoteForeground" = "#${config.colorScheme.colors.base07}";
    "statusBarItem.errorBackground" = "#${config.colorScheme.colors.base08}";
    "statusBarItem.errorForeground" = "#${config.colorScheme.colors.base07}";
    "statusBarItem.warningBackground" = "#${config.colorScheme.colors.base0A}";
    "statusBarItem.warningForeground" = "#${config.colorScheme.colors.base07}";

    "titleBar.activeBackground" = "#${config.colorScheme.colors.base00}";
    "titleBar.activeForeground" = "#${config.colorScheme.colors.base05}";
    "titleBar.inactiveBackground" = "#${config.colorScheme.colors.base01}";
    "titleBar.inactiveForeground" = "#${config.colorScheme.colors.base03}";

    "menubar.selectionForeground" = "#${config.colorScheme.colors.base05}";
    "menubar.selectionBackground" = "#${config.colorScheme.colors.base01}";
    "menu.foreground" = "#${config.colorScheme.colors.base05}";
    "menu.background" = "#${config.colorScheme.colors.base01}";
    "menu.selectionForeground" = "#${config.colorScheme.colors.base05}";
    "menu.selectionBackground" = "#${config.colorScheme.colors.base02}";
    "menu.separatorBackground" = "#${config.colorScheme.colors.base07}";

    "commandCenter.foreground" = "#${config.colorScheme.colors.base05}";
    "commandCenter.activeForeground" = "#${config.colorScheme.colors.base07}";
    "commandCenter.background" = "#${config.colorScheme.colors.base00}";
    "commandCenter.activeBackground" = "#${config.colorScheme.colors.base01}";

    "notificationCenterHeader.foreground" =
      "#${config.colorScheme.colors.base05}";
    "notificationCenterHeader.background" =
      "#${config.colorScheme.colors.base01}";
    "notifications.foreground" = "#${config.colorScheme.colors.base05}";
    "notifications.background" = "#${config.colorScheme.colors.base02}";
    "notificationLink.foreground" = "#${config.colorScheme.colors.base0D}";
    "notificationsErrorIcon.foreground" =
      "#${config.colorScheme.colors.base08}";
    "notificationsWarningIcon.foreground" =
      "#${config.colorScheme.colors.base0A}";
    "notificationsInfoIcon.foreground" = "#${config.colorScheme.colors.base0D}";

    "notification.background" = "#${config.colorScheme.colors.base02}";
    "notification.foreground" = "#${config.colorScheme.colors.base05}";
    "notification.buttonBackground" = "#${config.colorScheme.colors.base0D}";
    "notification.buttonHoverBackground" =
      "#${config.colorScheme.colors.base02}";
    "notification.buttonForeground" = "#${config.colorScheme.colors.base07}";
    "notification.infoBackground" = "#${config.colorScheme.colors.base0C}";
    "notification.infoForeground" = "#${config.colorScheme.colors.base07}";
    "notification.warningBackground" = "#${config.colorScheme.colors.base0A}";
    "notification.warningForeground" = "#${config.colorScheme.colors.base07}";
    "notification.errorBackground" = "#${config.colorScheme.colors.base08}";
    "notification.errorForeground" = "#${config.colorScheme.colors.base07}";

    "banner.background" = "#${config.colorScheme.colors.base02}";
    "banner.foreground" = "#${config.colorScheme.colors.base05}";
    "banner.iconForeground" = "#${config.colorScheme.colors.base0D}";

    "extensionButton.prominentBackground" =
      "#${config.colorScheme.colors.base0B}";
    "extensionButton.prominentForeground" =
      "#${config.colorScheme.colors.base07}";
    "extensionButton.prominentHoverBackground" =
      "#${config.colorScheme.colors.base02}";
    "extensionBadge.remoteBackground" = "#${config.colorScheme.colors.base09}";
    "extensionBadge.remoteForeground" = "#${config.colorScheme.colors.base07}";
    "extensionIcon.starForeground" = "#${config.colorScheme.colors.base0A}";
    "extensionIcon.verifiedForeground" = "#${config.colorScheme.colors.base0D}";
    "extensionIcon.preReleaseForeground" =
      "#${config.colorScheme.colors.base09}";

    "pickerGroup.foreground" = "#${config.colorScheme.colors.base03}";
    "quickInput.background" = "#${config.colorScheme.colors.base01}";
    "quickInput.foreground" = "#${config.colorScheme.colors.base05}";
    "quickInputList.focusBackground" = "#${config.colorScheme.colors.base03}";
    "quickInputList.focusForeground" = "#${config.colorScheme.colors.base07}";
    "quickInputList.focusIconForeground" =
      "#${config.colorScheme.colors.base07}";

    "keybindingLabel.background" = "#${config.colorScheme.colors.base02}";
    "keybindingLabel.foreground" = "#${config.colorScheme.colors.base05}";

    "keybindingTable.headerBackground" = "#${config.colorScheme.colors.base02}";
    "keybindingTable.rowsBackground" = "#${config.colorScheme.colors.base01}";

    "terminal.background" = "#${config.colorScheme.colors.base00}";
    "terminal.foreground" = "#${config.colorScheme.colors.base05}";
    "terminal.ansiBlack" = "#${config.colorScheme.colors.base00}";
    "terminal.ansiRed" = "#${config.colorScheme.colors.base08}";
    "terminal.ansiGreen" = "#${config.colorScheme.colors.base0B}";
    "terminal.ansiYellow" = "#${config.colorScheme.colors.base0A}";
    "terminal.ansiBlue" = "#${config.colorScheme.colors.base0D}";
    "terminal.ansiMagenta" = "#${config.colorScheme.colors.base0E}";
    "terminal.ansiCyan" = "#${config.colorScheme.colors.base0C}";
    "terminal.ansiWhite" = "#${config.colorScheme.colors.base05}";
    "terminal.ansiBrightBlack" = "#${config.colorScheme.colors.base03}";
    "terminal.ansiBrightRed" = "#${config.colorScheme.colors.base08}";
    "terminal.ansiBrightGreen" = "#${config.colorScheme.colors.base0B}";
    "terminal.ansiBrightYellow" = "#${config.colorScheme.colors.base0A}";
    "terminal.ansiBrightBlue" = "#${config.colorScheme.colors.base0D}";
    "terminal.ansiBrightMagenta" = "#${config.colorScheme.colors.base0E}";
    "terminal.ansiBrightCyan" = "#${config.colorScheme.colors.base0C}";
    "terminal.ansiBrightWhite" = "#${config.colorScheme.colors.base07}";
    "terminalCursor.foreground" = "#${config.colorScheme.colors.base05}";
    "terminalOverviewRuler.cursorForeground" = "#ff0000";
    "terminalOverviewRuler.findMatchForeground" = "#ff0000";

    "debugToolBar.background" = "#${config.colorScheme.colors.base01}";
    "debugView.stateLabelForeground" = "#${config.colorScheme.colors.base07}";
    "debugView.stateLabelBackground" = "#${config.colorScheme.colors.base0D}";
    "debugView.valueChangedHighlight" = "#${config.colorScheme.colors.base0D}";
    "debugTokenExpression.name" = "#${config.colorScheme.colors.base0E}";
    "debugTokenExpression.value" = "#${config.colorScheme.colors.base05}";
    "debugTokenExpression.string" = "#${config.colorScheme.colors.base0B}";
    "debugTokenExpression.boolean" = "#${config.colorScheme.colors.base09}";
    "debugTokenExpression.number" = "#${config.colorScheme.colors.base09}";
    "debugTokenExpression.error" = "#${config.colorScheme.colors.base08}";

    "testing.iconFailed" = "#${config.colorScheme.colors.base08}";
    "testing.iconErrored" = "#${config.colorScheme.colors.base0F}";
    "testing.iconPassed" = "#${config.colorScheme.colors.base0B}";
    "testing.runAction" = "#${config.colorScheme.colors.base04}";
    "testing.iconQueued" = "#${config.colorScheme.colors.base0A}";
    "testing.iconUnset" = "#${config.colorScheme.colors.base04}";
    "testing.iconSkipped" = "#${config.colorScheme.colors.base0E}";
    "testing.peekHeaderBackground" = "#${config.colorScheme.colors.base01}";
    "testing.message.error.decorationForeground" =
      "#${config.colorScheme.colors.base05}";
    "testing.message.error.lineBackground" =
      "#${config.colorScheme.colors.base08}20";
    "testing.message.info.decorationForeground" =
      "#${config.colorScheme.colors.base05}";
    "testing.message.info.lineBackground" =
      "#${config.colorScheme.colors.base0D}20";

    "welcomePage.background" = "#${config.colorScheme.colors.base00}";
    "welcomePage.buttonBackground" = "#${config.colorScheme.colors.base01}";
    "welcomePage.buttonHoverBackground" =
      "#${config.colorScheme.colors.base02}";
    "welcomePage.progress.background" = "#${config.colorScheme.colors.base03}";
    "welcomePage.progress.foreground" = "#${config.colorScheme.colors.base0D}";
    "welcomePage.tileBackground" = "#${config.colorScheme.colors.base01}";
    "welcomePage.tileHoverBackground" = "#${config.colorScheme.colors.base02}";
    "walkThrough.embeddedEditorBackground" =
      "#${config.colorScheme.colors.base00}";

    "gitDecoration.addedResourceForeground" =
      "#${config.colorScheme.colors.base0B}";
    "gitDecoration.modifiedResourceForeground" =
      "#${config.colorScheme.colors.base0E}";
    "gitDecoration.deletedResourceForeground" =
      "#${config.colorScheme.colors.base08}";
    "gitDecoration.renamedResourceForeground" =
      "#${config.colorScheme.colors.base0C}";
    "gitDecoration.stageModifiedResourceForeground" =
      "#${config.colorScheme.colors.base0E}";
    "gitDecoration.stageDeletedResourceForeground" =
      "#${config.colorScheme.colors.base08}";
    "gitDecoration.untrackedResourceForeground" =
      "#${config.colorScheme.colors.base09}";
    "gitDecoration.ignoredResourceForeground" =
      "#${config.colorScheme.colors.base03}";
    "gitDecoration.conflictingResourceForeground" =
      "#${config.colorScheme.colors.base0A}";
    "gitDecoration.submoduleResourceForeground" =
      "#${config.colorScheme.colors.base0F}";

    "settings.headerForeground" = "#${config.colorScheme.colors.base05}";
    "settings.modifiedItemIndicator" = "#${config.colorScheme.colors.base0D}";
    "settings.modifiedItemForeground" = "#${config.colorScheme.colors.base0B}";
    "settings.dropdownBackground" = "#${config.colorScheme.colors.base01}";
    "settings.dropdownForeground" = "#${config.colorScheme.colors.base05}";
    "settings.checkboxBackground" = "#${config.colorScheme.colors.base01}";
    "settings.checkboxForeground" = "#${config.colorScheme.colors.base05}";
    "settings.rowHoverBackground" = "#${config.colorScheme.colors.base02}";
    "settings.textInputBackground" = "#${config.colorScheme.colors.base01}";
    "settings.textInputForeground" = "#${config.colorScheme.colors.base05}";
    "settings.numberInputBackground" = "#${config.colorScheme.colors.base01}";
    "settings.numberInputForeground" = "#${config.colorScheme.colors.base05}";
    "settings.focusedRowBackground" = "#${config.colorScheme.colors.base02}";
    "settings.headerBorder" = "#${config.colorScheme.colors.base05}";
    "settings.sashBorder" = "#${config.colorScheme.colors.base05}";

    "breadcrumb.foreground" = "#${config.colorScheme.colors.base05}";
    "breadcrumb.background" = "#${config.colorScheme.colors.base01}";
    "breadcrumb.focusForeground" = "#${config.colorScheme.colors.base06}";
    "breadcrumb.activeSelectionForeground" =
      "#${config.colorScheme.colors.base07}";
    "breadcrumbPicker.background" = "#${config.colorScheme.colors.base01}";

    "editor.snippetTabstopHighlightBackground" =
      "#${config.colorScheme.colors.base02}";
    "editor.snippetFinalTabstopHighlightBackground" =
      "#${config.colorScheme.colors.base03}";

    "symbolIcon.arrayForeground" = "#${config.colorScheme.colors.base05}";
    "symbolIcon.booleanForeground" = "#${config.colorScheme.colors.base09}";
    "symbolIcon.classForeground" = "#${config.colorScheme.colors.base0A}";
    "symbolIcon.colorForeground" = "#f0f";
    "symbolIcon.constantForeground" = "#${config.colorScheme.colors.base09}";
    "symbolIcon.constructorForeground" = "#${config.colorScheme.colors.base0D}";
    "symbolIcon.enumeratorForeground" = "#${config.colorScheme.colors.base09}";
    "symbolIcon.enumeratorMemberForeground" =
      "#${config.colorScheme.colors.base0D}";
    "symbolIcon.eventForeground" = "#${config.colorScheme.colors.base0A}";
    "symbolIcon.fieldForeground" = "#${config.colorScheme.colors.base08}";
    "symbolIcon.fileForeground" = "#${config.colorScheme.colors.base05}";
    "symbolIcon.folderForeground" = "#${config.colorScheme.colors.base05}";
    "symbolIcon.functionForeground" = "#${config.colorScheme.colors.base0D}";
    "symbolIcon.interfaceForeground" = "#${config.colorScheme.colors.base0D}";
    "symbolIcon.keyForeground" = "#f0f";
    "symbolIcon.keywordForeground" = "#${config.colorScheme.colors.base0E}";
    "symbolIcon.methodForeground" = "#${config.colorScheme.colors.base0D}";
    "symbolIcon.moduleForeground" = "#${config.colorScheme.colors.base05}";
    "symbolIcon.namespaceForeground" = "#${config.colorScheme.colors.base05}";
    "symbolIcon.nullForeground" = "#${config.colorScheme.colors.base0F}";
    "symbolIcon.numberForeground" = "#${config.colorScheme.colors.base09}";
    "symbolIcon.objectForeground" = "#f0f";
    "symbolIcon.operatorForeground" = "#f0f";
    "symbolIcon.packageForeground" = "#f0f";
    "symbolIcon.propertyForeground" = "#${config.colorScheme.colors.base05}";
    "symbolIcon.referenceForeground" = "#f0f";
    "symbolIcon.snippetForeground" = "#${config.colorScheme.colors.base05}";
    "symbolIcon.stringForeground" = "#${config.colorScheme.colors.base0B}";
    "symbolIcon.structForeground" = "#${config.colorScheme.colors.base0A}";
    "symbolIcon.textForeground" = "#${config.colorScheme.colors.base05}";
    "symbolIcon.typeParameterForeground" = "#f0f";
    "symbolIcon.unitForeground" = "#f0f";
    "symbolIcon.variableForeground" = "#${config.colorScheme.colors.base08}";

    "debugIcon.breakpointForeground" = "#${config.colorScheme.colors.base08}";
    "debugIcon.breakpointDisabledForeground" =
      "#${config.colorScheme.colors.base04}";
    "debugIcon.breakpointUnverifiedForeground" =
      "#${config.colorScheme.colors.base02}";
    "debugIcon.breakpointCurrentStackframeForeground" =
      "#${config.colorScheme.colors.base0A}";
    "debugIcon.breakpointStackframeForeground" =
      "#${config.colorScheme.colors.base0F}";
    "debugIcon.startForeground" = "#${config.colorScheme.colors.base0B}";
    "debugIcon.pauseForeground" = "#${config.colorScheme.colors.base0D}";
    "debugIcon.stopForeground" = "#${config.colorScheme.colors.base08}";
    "debugIcon.disconnectForeground" = "#${config.colorScheme.colors.base08}";
    "debugIcon.restartForeground" = "#${config.colorScheme.colors.base0B}";
    "debugIcon.stepOverForeground" = "#${config.colorScheme.colors.base0D}";
    "debugIcon.stepIntoForeground" = "#${config.colorScheme.colors.base0C}";
    "debugIcon.stepOutForeground" = "#${config.colorScheme.colors.base0E}";
    "debugIcon.continueForeground" = "#${config.colorScheme.colors.base0B}";
    "debugIcon.stepBackForeground" = "#${config.colorScheme.colors.base0F}";
    "debugConsole.infoForeground" = "#${config.colorScheme.colors.base05}";
    "debugConsole.warningForeground" = "#${config.colorScheme.colors.base0A}";
    "debugConsole.errorForeground" = "#${config.colorScheme.colors.base08}";
    "debugConsole.sourceForeground" = "#${config.colorScheme.colors.base05}";
    "debugConsoleInputIcon.foreground" = "#${config.colorScheme.colors.base05}";

    "notebook.editorBackground" = "#${config.colorScheme.colors.base00}";
    "notebook.cellBorderColor" = "#${config.colorScheme.colors.base03}";
    "notebook.cellHoverBackground" = "#${config.colorScheme.colors.base01}";
    "notebook.cellToolbarSeparator" = "#${config.colorScheme.colors.base02}";
    "notebook.cellEditorBackground" = "#${config.colorScheme.colors.base00}";
    "notebook.focusedCellBackground" = "#${config.colorScheme.colors.base02}";
    "notebook.focusedCellBorder" = "#${config.colorScheme.colors.base0D}";
    "notebook.focusedEditorBorder" = "#${config.colorScheme.colors.base0D}";
    "notebook.inactiveFocusedCellBorder" =
      "#${config.colorScheme.colors.base03}";
    "notebook.selectedCellBackground" = "#${config.colorScheme.colors.base02}";
    "notebookStatusErrorIcon.foreground" =
      "#${config.colorScheme.colors.base08}";
    "notebookStatusRunningIcon.foreground" =
      "#${config.colorScheme.colors.base0C}";
    "notebookStatusSuccessIcon.foreground" =
      "#${config.colorScheme.colors.base0B}";

    "charts.foreground" = "#${config.colorScheme.colors.base05}";
    "charts.lines" = "#${config.colorScheme.colors.base05}";
    "charts.red" = "#${config.colorScheme.colors.base08}";
    "charts.blue" = "#${config.colorScheme.colors.base0D}";
    "charts.yellow" = "#${config.colorScheme.colors.base0A}";
    "charts.orange" = "#${config.colorScheme.colors.base09}";
    "charts.green" = "#${config.colorScheme.colors.base0B}";
    "charts.purple" = "#${config.colorScheme.colors.base0E}";

    "ports.iconRunningProcessForeground" =
      "#${config.colorScheme.colors.base09}";
  };
  "workbench.activityBar.location" = "hidden";
}
