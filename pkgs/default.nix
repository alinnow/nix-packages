{
  pkgs ? import <nixpkgs> { },
}:
{
  fishPlugins = pkgs.lib.makeScope pkgs.fishPlugins.newScope (
    self:
    pkgs.lib.packagesFromDirectoryRecursive {
      inherit (pkgs.fishPlugins) callPackage;
      directory = ./scoped/fishPlugins;
    }
  );
}
// pkgs.lib.packagesFromDirectoryRecursive {
  inherit (pkgs) callPackage;
  directory = ./by-directory;
}
