{
  lib,
  buildGoModule,
  fetchFromGitHub,
}:

buildGoModule {
  pname = "lunchy-go";
  version = "0.2.1-unstable-2022-02-12";

  src = fetchFromGitHub {
    owner = "sosedoff";
    repo = "lunchy-go";
    rev = "756ad7892ca91763c9c1e70ff9c6570607843725";
    hash = "sha256-YEaYtUH2bOIJ9I4JXcFAydCx30l11N8gszr7UlnqbF0=";
  };

  vendorHash = null;

  ldflags = [ "-s" ];

  postInstall = ''
    mv $out/bin/lunchy-go $out/bin/lunchy
  '';

  meta = {
    description = "A friendly wrapper for macOS launchctl.";
    homepage = "https://github.com/sosedoff/lunchy-go";
    license = lib.licenses.mit;
    maintainers = with lib.maintainers; [ alinnow ];
    mainProgram = "lunchy-go";
  };
}
