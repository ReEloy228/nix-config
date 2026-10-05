{ lib, newScope }:
lib.makeScope newScope (self: {
  dataview = self.callPackage ./plugins/dataview.nix { };
  excalidraw = self.callPackage ./plugins/excalidraw.nix { };
  kanban = self.callPackage ./plugins/kanban.nix { };
  ollama-assistant = self.callPackage ./plugins/ollama-assistant.nix { };
  calendar = self.callPackage ./plugins/calendar.nix { };
  linter = self.callPackage ./plugins/linter.nix { };
  tasks = self.callPackage ./plugins/tasks.nix { };
  advanced-tables = self.callPackage ./plugins/advanced-tables.nix { };
  rss-dashboard = self.callPackage ./plugins/rss-dashboard.nix { };
  image-converter = self.callPackage ./plugins/image-converter.nix { };
  editing-toolbar = self.callPackage ./plugins/editing-toolbar.nix { };
})
