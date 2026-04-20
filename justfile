[private]
default:
    @just --list

attrs:
    nix-instantiate --eval --raw \
        --expr 'builtins.concatStringsSep "\n" (import ./attrs.nix {})'
