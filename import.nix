let
  inherit (builtins)
    readDir
    concatLists
    attrNames
    match
    elem
    ;

  excludeFiles = [
    "configuration.nix"
    "hardware-configuration.nix"
    "import.nix"
    "flake.nix"
    "flake.lock"
  ];

  importRecursive =
    dir:
    let
      entries = readDir dir;
      processEntry =
        name:
        let
          type = entries.${name};
          fullPath = dir + "/${name}";
        in
        if type == "directory" then
          importRecursive fullPath
        else if match ".*\\.nix" name != null && !(elem name excludeFiles) then
          [ fullPath ]
        else
          [ ];
    in
    concatLists (map processEntry (attrNames entries));

  systemModules = (if builtins.pathExists ./system then importRecursive ./system else [ ]);
  homeModules = if builtins.pathExists ./modules then importRecursive ./modules else [ ];

  homeManagerModule = {
    home-manager.users.user = {
      imports = homeModules;
      home.stateVersion = "25.11";
    };
  };

in
systemModules ++ [ homeManagerModule ]
