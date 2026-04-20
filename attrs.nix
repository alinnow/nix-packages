{
  pkgs ? import <nixpkgs> { },
}:
let
  inherit (pkgs) lib;
  nurAttrs = import ./pkgs { inherit pkgs; };

  mapRecursive =
    path: value:
    if lib.isDerivation value then
      [
        (builtins.concatStringsSep "." path)
      ]
    else if builtins.isAttrs value then
      lib.concatMap (name: mapRecursive (path ++ [ name ]) value.${name}) (builtins.attrNames value)
    else
      [ ];
in
(mapRecursive [ ] nurAttrs)
