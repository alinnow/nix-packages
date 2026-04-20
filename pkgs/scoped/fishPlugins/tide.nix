{
  lib,
  tide,
  fetchFromGitHub,
}:

tide.overrideAttrs (oldAttrs: rec {
  version = "7.0.15";

  src = fetchFromGitHub {
    owner = "plttn";
    repo = "tide";
    tag = "v${version}";
    hash = "sha256-m0hJUCwUze1skhwKWCHDLfXL+ZPucSDaSr0z59rKjpk=";
  };

  meta = oldAttrs // {
    homepage = "https://github.com/plttn/tide";
    changelog = "https://github.com/plttn/tide/blob/${src.rev}/CHANGELOG.md";
    maintainers = with lib.maintainers; [ alinnow ];
  };
})
