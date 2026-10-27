{
  lib,
  hydro,
  fetchFromGitHub,
  unstableGitUpdater,
}:

hydro.overrideAttrs (
  finalAttrs: oldAttrs: {
    version = "0-unstable-2026-10-27";

    src = fetchFromGitHub {
      owner = "alinnow";
      repo = "hydro";
      rev = "e465a8c4940d5b8af52bc0d080e0cf02d08ea8eb";
      hash = "sha256-TEvzN1D0sXPx6fOIptv4YX1YZZCNOyjq9lPGaiAUb0I=";
    };

    passthru.updateScript = unstableGitUpdater { };

    meta = oldAttrs // {
      homepage = "https://github.com/alinnow/hydro";
      maintainers = with lib.maintainers; [ alinnow ];
    };
  }
)
