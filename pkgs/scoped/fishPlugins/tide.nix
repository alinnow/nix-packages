{
  lib,
  tide,
  fetchFromGitHub,
}:

tide.overrideAttrs (oldAttrs: rec {
  version = "7.0.12";

  src = fetchFromGitHub {
    owner = "plttn";
    repo = "tide";
    tag = "v${version}";
    hash = "sha256-VqbVrf84P59Inc+fc48evp3G62ur6yVVn2bIqI+O9FQ=";
  };

  meta = oldAttrs // {
    homepage = "https://github.com/plttn/tide";
    changelog = "https://github.com/plttn/tide/blob/${src.rev}/CHANGELOG.md";
    maintainers = with lib.maintainers; [ alinnow ];
  };
})
