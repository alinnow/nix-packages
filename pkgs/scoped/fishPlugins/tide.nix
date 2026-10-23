{
  lib,
  tide,
  fetchFromGitHub,
}:

tide.overrideAttrs (
  finalAttrs: oldAttrs: {
    version = "7.2.0";
    name = "${oldAttrs.pname}-${finalAttrs.version}";

    src = fetchFromGitHub {
      owner = "plttn";
      repo = "tide";
      tag = "v${finalAttrs.version}";
      hash = "sha256-93Q1hEfZ7wwUK1OGhLQMvngSItMOgZbBjnTN9sS2yiM=";
    };

    meta = oldAttrs // {
      homepage = "https://github.com/plttn/tide";
      changelog = "https://github.com/plttn/tide/blob/${finalAttrs.src.rev}/CHANGELOG.md";
      maintainers = with lib.maintainers; [ alinnow ];
    };
  }
)
