{
  lib,
  hydro,
  fetchFromGitHub,
  unstableGitUpdater,
}:

hydro.overrideAttrs (
  finalAttrs: oldAttrs: {
    version = "0-unstable-2026-10-23";

    src = fetchFromGitHub {
      owner = "alinnow";
      repo = "hydro";
      rev = "07dd02c5ce863c8f42d100a0a86a124294927e47";
      hash = "sha256-TmLirxR1uuTY/ybsfhIKDXcZb+50ohoE6mqn0H8+R70=";
    };

    passthru.updateScript = unstableGitUpdater { };

    meta = oldAttrs // {
      homepage = "https://github.com/alinnow/hydro";
      maintainers = with lib.maintainers; [ alinnow ];
    };
  }
)
