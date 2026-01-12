{ self, ... }: {
  nix.settings.experimental-features = "nix-command flakes";
  nixpkgs = {
    overlays = [ ];
    config = {
      allowUnfree = true;
      allowUnfreePredicate = (_: true);
    };
  };
}
