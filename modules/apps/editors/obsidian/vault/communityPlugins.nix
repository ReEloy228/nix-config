{ obsidianPlugins, ... }: {
  programs.obsidian.vaults."vault".settings.communityPlugins = with obsidianPlugins; [
    {
      pkg = dataview;
      enable = true;
      settings = {
        enableDataviewJs = true;
        enableInlineDataview = true;
      };
    }
    {
      pkg = excalidraw;
      enable = true;
    }
    {
      pkg = kanban;
      enable = true;
    }
    {
      pkg = ollama-assistant;
      enable = true;
      settings = {
        ollamaUrl = "http://localhost:11434";
        model = "qwen2.5-coder:7b";
      };
    }
    {
      pkg = calendar;
      enable = true;
      settings = {
        "dailyNotes" = true;
        "weekStart" = "monday";
        "showWeekNumber" = false;
      };
    }
    {
      pkg = linter;
      enable = true;
      settings = {
        lintOnSave = true;
        displayChanged = false;
      };
    }
    {
      pkg = tasks;
      enable = true;
      settings = {
        "globalFilter" = "#task";
        "globalQuery" = "path does not include Templates";
        "setCreatedDate" = true;
      };
    }
    {
      pkg = advanced-tables;
      enable = true;
      settings = {
        "tableEditor" = true;
        "autoFormat" = true;
      };
    }
    {
      pkg = rss-dashboard;
      enable = true;
      settings = {
        "refreshInterval" = 30;
        "maxArticlesPerFeed" = 100;
      };
    }
    {
      pkg = image-converter;
      enable = true;
      settings = {
        "outputFormat" = "webp";
        "compressionQuality" = 80;
      };
    }
    {
      pkg = editing-toolbar;
      enable = true;
      settings = {
        "toolbarStyle" = "tiny";
        "toolbarPosition" = "top";
      };
    }
  ];
}
