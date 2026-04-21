{
  lib,
  buildNpmPackage,
  fetchFromGitHub,
}:

buildNpmPackage rec {
  pname = "danube-cli";
  version = "0.10.0";

  src = fetchFromGitHub {
    owner = "AdrianSilaghi";
    repo = "danube-cli";
    tag = "v${version}";
    hash = "sha256-9M03DpHN7FDnszVMunbG9jvFjirOEV/mUd3tIF9N/WI=";
  };

  npmDepsHash = "sha256-pqWAScISFbfxMdeS3+wn2XD0pRiK0C5tdYglcGA1Bqs=";

  meta = {
    description = "Deploy static sites to DanubeData from the terminal";
    homepage = "https://github.com/AdrianSilaghi/danube-cli";
    license = lib.licenses.mit;
    maintainers = with lib.maintainers; [ alinnow ];
    mainProgram = "danube-cli";
    platforms = lib.platforms.all;
  };
}
