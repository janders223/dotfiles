{
  darwin = ./darwin.nix;
  home-manager = "${
      builtins.fetchTarball
      "https://github.com/rycee/home-manager/archive/7f7348b47049e8d25fb5b98db1d6215f8f643f0d.tar.gz"
    }/nix-darwin";
}
