{
  lib,
  buildFishPlugin,
  fetchFromGitHub,
}:
buildFishPlugin {
  pname = "ghq";
  version = "0-unstable-2021-07-16";

  src = fetchFromGitHub {
    owner = "decors";
    repo = "fish-ghq";
    sha256 = "0cv7jpvdfdha4hrnjr887jv1pc6vcrxv2ahy7z6x562y7fd77gg9";
    # date = "2021-07-16T13:17:09+09:00";
    rev = "cafaaabe63c124bf0714f89ec715cfe9ece87fa2";
  };

  meta = {
    description = "Completions and keybinding for ghq";
    license = lib.licenses.mit;
    maintainers = with lib.maintainers; [ alinnow ];
    platforms = with lib.platforms; [ unix ];
  };
}
